import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Centralized Firebase Analytics Service
/// Use this service to track events throughout the app
class FirebaseAnalyticsService {
  static final FirebaseAnalyticsService instance = FirebaseAnalyticsService._internal();

  FirebaseAnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Get the FirebaseAnalytics instance if needed for advanced usage
  FirebaseAnalytics get analytics => _analytics;

  /// Helper method to log analytics events for debugging
  void _logAnalyticsEvent(String eventName, Map<String, Object?>? parameters) {
    if (kDebugMode) {
      debugPrint('📊 [Firebase Analytics] Event: $eventName');
      if (parameters != null && parameters.isNotEmpty) {
        debugPrint('📊 [Firebase Analytics] Parameters:');
        parameters.forEach((key, value) {
          debugPrint('   - $key: ${value ?? 'null'}');
        });
      } else {
        debugPrint('📊 [Firebase Analytics] Parameters: (none)');
      }
    }
  }

  // ============================================
  // AUTHENTICATION EVENTS
  // ============================================

  /// Track login button press
  Future<void> logLoginButtonPressed({String? username}) async {
    final parameters = {if (username != null) 'username': username};
    await _analytics.logEvent(name: 'login_button_pressed', parameters: parameters);
    _logAnalyticsEvent('login_button_pressed', parameters);
  }

  /// Track successful login
  Future<void> logLogin({required String loginMethod, String? username}) async {
    final loginParams = {'login_method': loginMethod};
    await _analytics.logLogin(loginMethod: loginMethod);
    _logAnalyticsEvent('login', loginParams);

    if (username != null) {
      final successParams = {'login_method': loginMethod, 'username': username};
      await _analytics.logEvent(name: 'login_success', parameters: successParams);
      _logAnalyticsEvent('login_success', successParams);
    }
  }

  /// Track failed login attempt
  Future<void> logLoginFailed({String? username, String? reason}) async {
    final parameters = {
      if (username != null) 'username': username,
      if (reason != null) 'reason': reason,
    };
    await _analytics.logEvent(name: 'login_failed', parameters: parameters);
    _logAnalyticsEvent('login_failed', parameters);
  }

  /// Track biometric login attempt
  Future<void> logBiometricLoginAttempted({required String biometricType}) async {
    final parameters = {'biometric_type': biometricType};
    await _analytics.logEvent(name: 'biometric_login_attempted', parameters: parameters);
    _logAnalyticsEvent('biometric_login_attempted', parameters);
  }

  /// Track successful biometric login
  Future<void> logBiometricLoginSuccess({required String biometricType}) async {
    final parameters = {'login_method': biometricType};
    await _analytics.logLogin(loginMethod: biometricType);
    _logAnalyticsEvent('login', parameters);
  }

  /// Track failed biometric login
  Future<void> logBiometricLoginFailed({required String biometricType, String? reason}) async {
    final parameters = {'biometric_type': biometricType, if (reason != null) 'reason': reason};
    await _analytics.logEvent(name: 'biometric_login_failed', parameters: parameters);
    _logAnalyticsEvent('biometric_login_failed', parameters);
  }

  /// Track logout
  Future<void> logLogout() async {
    await _analytics.logEvent(name: 'logout');
    _logAnalyticsEvent('logout', null);
  }

  // ============================================
  // PAYMENT EVENTS
  // ============================================

  /// Track payment button press
  Future<void> logPaymentButtonPressed({
    required double value,
    required String currency,
    bool? hasPackage,
    int? servicesCount,
  }) async {
    final parameters = {
      'value': value,
      'currency': currency,
      if (hasPackage != null) 'has_package': hasPackage,
      if (servicesCount != null) 'services_count': servicesCount,
    };
    await _analytics.logEvent(name: 'payment_button_pressed', parameters: parameters);
    _logAnalyticsEvent('payment_button_pressed', parameters);
  }

  /// Track begin checkout (when payment process starts)
  Future<void> logBeginCheckout({
    required double value,
    required String currency,
    List<AnalyticsEventItem>? items,
  }) async {
    final parameters = {'value': value, 'currency': currency, 'items_count': items?.length ?? 0};
    await _analytics.logBeginCheckout(value: value, currency: currency, items: items);
    _logAnalyticsEvent('begin_checkout', parameters);
  }

  /// Track successful purchase
  Future<void> logPurchase({
    required double value,
    required String currency,
    required String transactionId,
    List<AnalyticsEventItem>? items,
  }) async {
    final parameters = {
      'value': value,
      'currency': currency,
      'transaction_id': transactionId,
      'items_count': items?.length ?? 0,
    };
    await _analytics.logPurchase(
      value: value,
      currency: currency,
      transactionId: transactionId,
      items: items,
    );
    _logAnalyticsEvent('purchase', parameters);
  }

  /// Track payment failure
  Future<void> logPaymentFailed({
    required double value,
    required String currency,
    required String reason,
  }) async {
    final parameters = {'value': value, 'currency': currency, 'reason': reason};
    await _analytics.logEvent(name: 'payment_failed', parameters: parameters);
    _logAnalyticsEvent('payment_failed', parameters);
  }

  /// Track payment error
  Future<void> logPaymentError({
    required double value,
    required String currency,
    String? error,
  }) async {
    final parameters = {'value': value, 'currency': currency, if (error != null) 'error': error};
    await _analytics.logEvent(name: 'payment_error', parameters: parameters);
    _logAnalyticsEvent('payment_error', parameters);
  }

  // ============================================
  // E-COMMERCE EVENTS
  // ============================================

  /// Track add to cart
  Future<void> logAddToCart({
    required String itemId,
    required String itemName,
    required String itemCategory,
    required double price,
    required int quantity,
  }) async {
    final parameters = {
      'currency': 'SAR',
      'value': price * quantity,
      'item_id': itemId,
      'item_name': itemName,
      'item_category': itemCategory,
      'price': price,
      'quantity': quantity,
    };
    await _analytics.logAddToCart(
      currency: 'SAR',
      value: price * quantity,
      items: [
        AnalyticsEventItem(
          itemId: itemId,
          itemName: itemName,
          itemCategory: itemCategory,
          price: price,
          quantity: quantity,
        ),
      ],
    );
    _logAnalyticsEvent('add_to_cart', parameters);
  }

  /// Track remove from cart
  Future<void> logRemoveFromCart({
    required String itemId,
    required String itemName,
    required String itemCategory,
    required double price,
    required int quantity,
  }) async {
    final parameters = {
      'currency': 'SAR',
      'value': price * quantity,
      'item_id': itemId,
      'item_name': itemName,
      'item_category': itemCategory,
      'price': price,
      'quantity': quantity,
    };
    await _analytics.logEvent(
      name: 'remove_from_cart',
      parameters: {
        'currency': 'SAR',
        'value': price * quantity,
        'items': [
          {
            'item_id': itemId,
            'item_name': itemName,
            'item_category': itemCategory,
            'price': price,
            'quantity': quantity,
          },
        ],
      },
    );
    _logAnalyticsEvent('remove_from_cart', parameters);
  }

  /// Track view item
  Future<void> logViewItem({
    required String itemId,
    required String itemName,
    required String itemCategory,
    double? price,
  }) async {
    final parameters = <String, Object>{
      'currency': 'SAR',
      'item_id': itemId,
      'item_name': itemName,
      'item_category': itemCategory,
      if (price != null) 'value': price,
      if (price != null) 'price': price,
    };
    await _analytics.logViewItem(
      currency: 'SAR',
      value: price,
      items: [
        AnalyticsEventItem(
          itemId: itemId,
          itemName: itemName,
          itemCategory: itemCategory,
          price: price,
          quantity: 1,
        ),
      ],
    );
    _logAnalyticsEvent('view_item', parameters);
  }

  // ============================================
  // SCREEN VIEWS
  // ============================================

  /// Track screen view
  Future<void> logScreenView({required String screenName, String? screenClass}) async {
    final parameters = {'screen_name': screenName, 'screen_class': screenClass ?? screenName};
    await _analytics.logScreenView(screenName: screenName, screenClass: screenClass ?? screenName);
    _logAnalyticsEvent('screen_view', parameters);
  }

  // ============================================
  // CUSTOM EVENTS
  // ============================================

  /// Track custom event
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
    _logAnalyticsEvent(name, parameters);
  }

  // ============================================
  // USER PROPERTIES
  // ============================================

  /// Set user property
  Future<void> setUserProperty({required String name, required String? value}) async {
    await _analytics.setUserProperty(name: name, value: value);
    if (kDebugMode) {
      debugPrint('📊 [Firebase Analytics] User Property Set: $name = $value');
    }
  }

  /// Set user ID
  Future<void> setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
    if (kDebugMode) {
      debugPrint('📊 [Firebase Analytics] User ID Set: $userId');
    }
  }

  /// Reset analytics data (on logout)
  Future<void> resetAnalyticsData() async {
    await _analytics.resetAnalyticsData();
    if (kDebugMode) {
      debugPrint('📊 [Firebase Analytics] Analytics data reset');
    }
  }

  // ============================================
  // SEARCH EVENTS
  // ============================================

  /// Track search
  Future<void> logSearch({required String searchTerm}) async {
    final parameters = {'search_term': searchTerm};
    await _analytics.logSearch(searchTerm: searchTerm);
    _logAnalyticsEvent('search', parameters);
  }

  // ============================================
  // SHARE EVENTS
  // ============================================

  /// Track share
  Future<void> logShare({
    required String contentType,
    required String itemId,
    required String method,
  }) async {
    final parameters = {'content_type': contentType, 'item_id': itemId, 'method': method};
    await _analytics.logShare(contentType: contentType, itemId: itemId, method: method);
    _logAnalyticsEvent('share', parameters);
  }

  // ============================================
  // SIGN UP EVENTS
  // ============================================

  /// Track sign up
  Future<void> logSignUp({required String signUpMethod}) async {
    final parameters = {'sign_up_method': signUpMethod};
    await _analytics.logSignUp(signUpMethod: signUpMethod);
    _logAnalyticsEvent('sign_up', parameters);
  }
}
