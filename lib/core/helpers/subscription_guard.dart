import '../../features/account/domain/use_cases/get_client_subscription_status_use_case.dart';
import '../../injection_container/account/account_injection.dart';
import '../../injection_container/injection_container.dart';
import '../../shared_widgets/subscription_expired_dialog.dart';
import 'preferences_manager.dart';

/// Returns true when the client may perform an operation.
///
/// Blocks (and shows the renewal dialog) only when the server confirms the
/// subscription is not active. If the status can't be determined (no user,
/// network error, non-200), the operation is allowed so a flaky request
/// doesn't lock out a paying client.
Future<bool> ensureActiveSubscription() async {
  final clientId = TpPreferencesManager.retrieveString(TpPreferencesManager.userId) ?? '';
  if (clientId.isEmpty) return true;

  accountInit(sl);
  final result = await sl<GetClientSubscriptionStatusUseCase>()(
    GetClientSubscriptionStatusParams(clientId: clientId),
  );

  final active = result.fold<bool>((_) => true, (response) {
    if (response.statusCode != 200) return true;
    return response.isSubscriptionActive;
  });

  if (!active) {
    result.fold((_) {}, (response) {
      showSubscriptionExpiredDialog(endDateLabel: response.subscriptionEndDate);
    });
  }
  return active;
}

/// Runs [action] only when the subscription is active.
Future<void> runIfSubscriptionActive(Future<void> Function() action) async {
  if (await ensureActiveSubscription()) {
    await action();
  }
}
