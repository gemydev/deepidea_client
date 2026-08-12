import 'package:get/get.dart';

/// Drives [BaseOfApp] tab index and optional ticket status filter for [TicketOrdersFollow].
class BaseShellNavigationController extends GetxController {
  final RxInt selectedPageIndex = 0.obs;

  /// When non-null, the next [TicketOrdersFollow] build uses this as initial filter (status id).
  final Rxn<int> ticketOrdersFilterStatusId = Rxn<int>();

  void goToTicketsWithStatusFilter(int statusId) {
    ticketOrdersFilterStatusId.value = statusId;
    selectedPageIndex.value = 1;
  }
}
