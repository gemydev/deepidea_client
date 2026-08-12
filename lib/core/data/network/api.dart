import '../../helpers/preferences_manager.dart';

class Api {
  static const String baseUrl = 'https://dev2.newgooobig.com';
  //static const String baseUrl = 'http://aap-soloutions.com';
  static const String baseUrlPortal = '$baseUrl/MyPortalStoreAPI/';

  /// Required on `loginForClient` and other portal calls (HTTP header `siteId`).
  static const String portalSiteId = '1111';

  static String login() => 'loginForClient';

  static String sendClientForgotPasswordOtp() => 'sendClientForgotPasswordOtp';

  static String resetClientPasswordWithOtp() => 'resetClientPasswordWithOtp';

  static String changeClientPassword() => 'ChangeClientPassword';

  static String sendOtpVerification() => 'api/ClientAccount/sendOtpVerification';

  static String verifyOtp() => 'api/ClientAccount/verifyOtp';

  static String logout() => 'logout';

  static String getListOfPackagesWithFav(String id) => 'getListOfPackagesWithFav/$id';

  static String getServicesListOfPackagesWithFav(String id) =>
      'ServicesgetListOfPackagesWithFav/$id';

  static String getListOfActivity() => 'getListOfActivity';

  static String postInvoicesWithConfirm() => 'postInvoicesWithConfirm';

  static String getPackagesFromPackageBundle(String id, String invoiceId) =>
      'GetPackagesFromPackageBundle/$id?invoiceId=$invoiceId';

  static String getServiceFromServiceId(String serviceId, String invoiceId) =>
      'getServiceFromServiceId/$serviceId/$invoiceId';

  static String getAllServicesByWebId() =>
      'GetAllServicesByWebId?webId=${TpPreferencesManager.retrieveString(TpPreferencesManager.websiteId)}';

  static String getInvoicesAndPackages() => 'getInvoicesAndPackages';

  static String submitSalesDelivery() => 'SubmitSalesDelivery';

  static String getPackages() => 'getPackages';

  static String getRegisteredServicesAndPackages() => 'GetRegisteredServicesAndPackages';

  static String getServiceDetails(String serviceId) => 'GetServiceDetails?serviceId=$serviceId';

  static String getServiceDetailsByWebId(String webId) => 'GetServiceDetailsByWebId?webId=$webId';

  // Tickets
  static String getAllTicketCategories({int? parentId}) {
    if (parentId == null) {
      return 'GetAllTicketCategories';
    }
    return 'GetAllTicketCategories?parentId=$parentId';
  }

  /// @deprecated Use [getAllTicketCategories] instead.
  static String getTicketCategories() => getAllTicketCategories();

  static String getAllTickets() =>
      'GetAllTickets?userId=${TpPreferencesManager.retrieveString(TpPreferencesManager.userId)}&websiteid=${TpPreferencesManager.retrieveString(TpPreferencesManager.websiteId)}';

  static String getAllTicketFAQ() => 'GetAllTicketFAQ';

  static String getFAQsByCategory(int categoryId) => 'GetFAQsByCategory?categoryId=$categoryId';

  static String getTicketDetails(String ticketId) => 'GetTicketDetails?ticketId=$ticketId';

  static String submitTicketWithFiles() => 'SubmitTicketWithFiles';

  static String getTicketConversation(String ticketId) =>
      'GetTicketConversation?ticketId=$ticketId';

  static String closeTicket(String ticketId) => 'CloseTicket?ticketId=$ticketId';

  static String replyUserTicket() => 'ReplyUserTicke';

  static String reOpenTicket() => 'ReOpenTicket';

  static String uploadFiles() => 'UploadFiles';

  // Chat
  static String sendMessage() => 'api/Chat/send';

  static String availableSupporter() =>
      'api/Calls/availableSupporter?clientId=${TpPreferencesManager.retrieveString(TpPreferencesManager.userId)}';

  static String getConversation(String senderId, String receiverId) =>
      'api/Conversation/GetConversation/$senderId/$receiverId';

  static String getClientSubscriptionStatus(String clientId) =>
      'GetClientSubscriptionStatus/$clientId';
}
