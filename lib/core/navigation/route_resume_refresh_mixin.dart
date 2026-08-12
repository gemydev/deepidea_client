import 'package:flutter/material.dart';

import 'app_route_observer.dart';

/// Calls [refreshWhenRouteResumed] when the user pops back to this screen.
mixin RouteResumeRefreshMixin<T extends StatefulWidget> on State<T> implements RouteAware {
  ModalRoute<void>? _subscribedRoute;

  @override
  void didPop() {}

  @override
  void didPush() {}

  @override
  void didPushNext() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route == null || route == _subscribedRoute) {
      return;
    }
    if (_subscribedRoute != null) {
      appRouteObserver.unsubscribe(this);
    }
    _subscribedRoute = route;
    appRouteObserver.subscribe(this, route);
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    refreshWhenRouteResumed();
  }

  /// Reload server-backed data for this screen.
  void refreshWhenRouteResumed();
}
