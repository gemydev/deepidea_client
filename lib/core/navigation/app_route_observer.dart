import 'package:flutter/material.dart';

/// Global [RouteObserver] for [RouteResumeRefreshMixin] and similar listeners.
final RouteObserver<ModalRoute<void>> appRouteObserver =
    RouteObserver<ModalRoute<void>>();
