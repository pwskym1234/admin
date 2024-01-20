import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension GoRouterX on GoRouter {
  BuildContext? get context => configuration.navigatorKey.currentContext;
  OverlayState? get overlayState {
    final context = this.context;
    if (context == null) return null;
    return Overlay.of(context);
  }

  Uri get currentUri => routeInformationProvider.value.uri;
}
