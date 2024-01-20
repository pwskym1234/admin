import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/data/extension/go_router.dart';
import 'package:admin/feature/error/error_page.dart';
import 'package:admin/main.dart';

final routerServiceProvider = Provider<RouterService>((ref) {
  final service = RouterService();
  service.init();
  return service;
});

class RouterService {
  Uri _currentUri = Uri();
  Uri get currentUri => _currentUri;
  set currentUri(Uri value) => _currentUri = value;

  Future<T?> openDialog<T>({
    required Widget Function(BuildContext) builder,
  }) async {
    final context = goRouter.context;
    if (context != null) {
      return showDialog<T>(context: context, builder: builder);
    }
    return null;
  }

  // void openLoading({
  //   required Completer<void> completer,
  //   required String text,
  // }) async {
  //   final context = goRouter.context;
  //   if (context != null) {
  //     return showDialog(
  //       context: context,
  //       barrierColor: Colors.transparent,
  //       barrierDismissible: false,
  //       builder: (context) => LoadingOverlay(
  //         completer: completer,
  //         text: text,
  //       ),
  //     );
  //   }
  // }

  late final GoRouter goRouter;

  Future<RouterService> init() async {
    goRouter = GoRouter(
      redirect: (context, state) {
        currentUri = state.uri;
        return null;
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const MyHomePage(),
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
    );
    return this;
  }
}
