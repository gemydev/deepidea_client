import '../../features/account/data/models/responses/client_subscription_status_response.dart';
import '../../features/account/domain/use_cases/get_client_subscription_status_use_case.dart';
import '../../injection_container/account/account_injection.dart';
import '../../injection_container/injection_container.dart';
import '../../shared_widgets/subscription_expiring_dialog.dart';
import 'preferences_manager.dart';

const int kSubscriptionExpiryReminderDays = 7;

bool _checkInProgress = false;

/// Fetches subscription status and shows a reminder when expiry is within [kSubscriptionExpiryReminderDays] days.
Future<void> checkAndShowSubscriptionExpiryReminder() async {
  if (_checkInProgress) return;

  final loggedIn = TpPreferencesManager.retrieveBool(TpPreferencesManager.isLoggedIn) ?? false;
  if (!loggedIn) return;

  final clientId = TpPreferencesManager.retrieveString(TpPreferencesManager.userId) ?? '';
  if (clientId.isEmpty) return;

  _checkInProgress = true;
  try {
    accountInit(sl);
    final result = await sl<GetClientSubscriptionStatusUseCase>()(
      GetClientSubscriptionStatusParams(clientId: clientId),
    );

    result.fold((_) {}, (response) {
      if (response.statusCode != 200) return;
      if (!shouldShowSubscriptionExpiryReminder(response)) return;
      final days = resolveSubscriptionRemainingDays(response);
      if (days == null) return;
      showSubscriptionExpiringDialog(
        remainingDays: days,
        endDateLabel: response.subscriptionEndDate,
      );
    });
  } finally {
    _checkInProgress = false;
  }
}

bool shouldShowSubscriptionExpiryReminder(ClientSubscriptionStatusResponse response) {
  if (!response.isSubscriptionActive) return false;
  final days = resolveSubscriptionRemainingDays(response);
  if (days == null) return false;
  return days >= 0 && days <= kSubscriptionExpiryReminderDays;
}

int? resolveSubscriptionRemainingDays(ClientSubscriptionStatusResponse response) {
  if (response.remainingDays != null) {
    return response.remainingDays!.toInt();
  }
  final endStr = response.subscriptionEndDate;
  if (endStr == null || endStr.isEmpty) return null;
  try {
    final end = DateTime.parse(endStr);
    final now = DateTime.now();
    final endDate = DateTime(end.year, end.month, end.day);
    final today = DateTime(now.year, now.month, now.day);
    return endDate.difference(today).inDays;
  } catch (_) {
    return null;
  }
}

String subscriptionRemainingDaysMessage(int remainingDays) {
  if (remainingDays <= 0) {
    return 'ينتهي اشتراكك اليوم. يرجى التجديد لتجنب انقطاع الخدمة.';
  }
  if (remainingDays == 1) {
    return 'يتبقى يوم واحد على انتهاء اشتراكك. يرجى التجديد في أقرب وقت.';
  }
  if (remainingDays == 2) {
    return 'يتبقى يومان على انتهاء اشتراكك. يرجى التجديد في أقرب وقت.';
  }
  return 'يتبقى $remainingDays أيام على انتهاء اشتراكك. يرجى التجديد في أقرب وقت.';
}
