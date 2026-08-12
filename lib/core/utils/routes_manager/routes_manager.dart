import 'package:remotely/features/account/presentation/screens/account.dart';
import 'package:remotely/features/home/presentation/screens/home.dart';
import 'package:remotely/features/support/presentation/screens/support.dart';
import 'package:get/get.dart';

import '../../../features/account/presentation/screens/companies_activities.dart';
import '../../../features/account/presentation/screens/contract.dart';
import '../../../features/account/presentation/screens/families_activities.dart';
import '../../../features/account/presentation/screens/favorites.dart';
import '../../../features/account/presentation/screens/friends_invitation.dart';
import '../../../features/account/presentation/screens/invoices.dart';
import '../../../features/account/presentation/screens/loyalty_points.dart';
import '../../../features/account/presentation/screens/orders.dart';
import '../../../features/account/presentation/screens/praivacy.dart';
import '../../../features/account/presentation/screens/profile.dart';
import '../../../features/account/presentation/screens/terms.dart';
import '../../../features/account/presentation/screens/who_we.dart';
import '../../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../../features/auth/presentation/screens/login.dart';
import '../../../features/auth/presentation/screens/otp.dart';
import '../../../features/auth/presentation/screens/reset_forgot_password_screen.dart';
import '../../../features/base_of_app.dart';
import '../../../features/cart/presentation/screens/cart.dart';
import '../../../features/cart/presentation/screens/payment.dart';
import '../../../features/cart/presentation/screens/wallet.dart';
import '../../../features/home/presentation/screens/order_service.dart';
import '../../../features/home/presentation/screens/service_details.dart';
import '../../../features/home/presentation/widgets/custom_callender_page.dart';
import '../../../features/notifications/presentation/notifications.dart';
import '../../../features/onboarding/presentation/screens/onboarding.dart';
import '../../../features/onboarding/presentation/screens/splash.dart';
import '../../../features/progress/presentation/screens/package_details.dart';
import '../../../features/progress/presentation/screens/progress.dart';
import '../../../features/progress/presentation/screens/subscriptions.dart';
import '../../../features/servicies/presentaion/screens/all_services.dart';
import '../../../features/servicies/presentaion/screens/services.dart';
import '../../../features/servicies/presentaion/screens/services_additions.dart';
import '../../../features/support/presentation/screens/create_ticket_order.dart';
import '../../../features/support/presentation/screens/orders_follow.dart';
import '../../../features/support/presentation/screens/ticket_details_screen.dart';

class Routes {
  Routes._();

  static const animation = Transition.cupertino;

  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String login = "/login";
  static const String forgotPassword = "/forgotPassword";
  static const String resetForgotPassword = "/resetForgotPassword";
  static const String selectServiceScreen = "/selectServiceScreen";
  static const String baseOfApp = "/baseOfApp";
  static const String oTPScreen = "/oTPScreen";
  static const String homeScreen = "/homeScreen";
  static const String customCalendarPage = "/customCalendarPage";
  static const String accountScreen = "/accountScreen";
  static const String progressScreen = "/progressScreen";
  static const String subscriptionsScreen = "/subscriptionsScreen";
  static const String packagesFromBundleScreen = "/packagesFromBundleScreen";
  static const String createTicketOrder = "/createTicketOrder";
  static const String ticketOrdersFollow = "/ticketOrdersFollow";
  static const String ticketDetails = "/ticketDetails";
  static const String services = "/services";
  static const String servicesAndAdditions = "/servicesAndAdditions";
  static const String allServices = "/allServices";
  static const String serviceDetails = "/serviceDetails";
  static const String friendsInvitation = "/friendsInvitation";
  static const String whoWe = "/whoWe";
  static const String loyaltyPoints = "/loyaltyPoints";
  static const String invoices = "/invoices";
  static const String orders = "/orders";
  static const String profile = "/profile";
  static const String favorites = "/favorites";
  static const String privacy = "/privacy";
  static const String contract = "/contract";
  static const String terms = "/terms";
  static const String notifications = "/notifications";
  static const String cart = "/cart";
  static const String payment = "/payment";
  static const String edfaaPayScreen = "/edfaaPayScreen";
  static const String wallet = "/wallet";
  static const String familiesActivities = "/familiesActivities";
  static const String companiesActivities = "/companiesActivities";
  static const String chat = "/chat";
  static const String orderService = "/orderService";

  static final routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen(), transition: animation),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen(), transition: animation),
    GetPage(name: login, page: () => const LoginScreen(), transition: animation),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen(), transition: animation),
    GetPage(
      name: resetForgotPassword,
      page: () => const ResetForgotPasswordScreen(),
      transition: animation,
    ),
    GetPage(name: oTPScreen, page: () => const OTPScreen(), transition: animation),
    GetPage(name: baseOfApp, page: () => const BaseOfApp(), transition: animation),
    GetPage(name: homeScreen, page: () => const HomeScreen(), transition: animation),
    GetPage(name: customCalendarPage, page: () => CustomCalendarPage(), transition: animation),
    GetPage(name: accountScreen, page: () => const AccountScreen(), transition: animation),
    GetPage(name: progressScreen, page: () => const ProgressScreen(), transition: animation),
    GetPage(
      name: subscriptionsScreen,
      page: () => const SubscriptionsScreen(),
      transition: animation,
    ),
    GetPage(
      name: packagesFromBundleScreen,
      page: () => PackagesFromBundleScreen(),
      transition: animation,
    ),
    GetPage(name: accountScreen, page: () => const SupportScreen(), transition: animation),
    GetPage(name: createTicketOrder, page: () => const CreateTicketOrder(), transition: animation),
    GetPage(
      name: ticketOrdersFollow,
      page: () => const TicketOrdersFollow(),
      transition: animation,
    ),
    GetPage(
      name: ticketDetails,
      page: () => const TicketDetailsScreen(),
      transition: animation,
    ),
    GetPage(name: services, page: () => const Services(), transition: animation),
    GetPage(
      name: servicesAndAdditions,
      page: () => const ServicesAndAdditions(),
      transition: animation,
    ),
    GetPage(name: allServices, page: () => const AllServices(), transition: animation),
    GetPage(name: serviceDetails, page: () => const ServiceDetails(), transition: animation),
    GetPage(name: friendsInvitation, page: () => const FriendsInvitation(), transition: animation),
    GetPage(name: whoWe, page: () => const WhoWe(), transition: animation),
    GetPage(name: loyaltyPoints, page: () => const LoyaltyPoints(), transition: animation),
    GetPage(name: invoices, page: () => const Invoices(), transition: animation),
    GetPage(name: orders, page: () => const Orders(), transition: animation),
    GetPage(name: profile, page: () => const Profile(), transition: animation),
    GetPage(name: favorites, page: () => const Favorites(), transition: animation),
    GetPage(name: privacy, page: () => const Privacy(), transition: animation),
    GetPage(name: contract, page: () => const Contract(), transition: animation),
    GetPage(name: terms, page: () => const Terms(), transition: animation),
    GetPage(name: notifications, page: () => const Notifications(), transition: animation),
    GetPage(name: cart, page: () => const Cart(), transition: animation),
    GetPage(name: payment, page: () => const Payment(), transition: animation),
    GetPage(name: wallet, page: () => const Wallet(), transition: animation),
    GetPage(
      name: familiesActivities,
      page: () => const FamiliesActivities(),
      transition: animation,
    ),
    GetPage(
      name: companiesActivities,
      page: () => const CompaniesActivities(),
      transition: animation,
    ),
    GetPage(name: orderService, page: () => const OrderService(), transition: animation),
  ];
}
