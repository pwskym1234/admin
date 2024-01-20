import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:admin/ui/e_simple_notify.dart';

// class ErrorInterceptorWrapper extends InterceptorsWrapper {
//   final SimpleNotify notifier;

//   ErrorInterceptorWrapper({
//     required this.notifier,
//   });

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     if (err.requestOptions.extra["needFeedback"] == true) {
//       notifier.show(,"에러코드 ${err.response?.statusCode}: ${err.message}");
//     }
//     if (!kReleaseMode) {
//       FirebaseCrashlytics.instance.recordError(
//         err,
//         StackTrace.current,
//         reason: "DioException",
//       );
//     }
//     super.onError(err, handler);
//   }
// }

class ErrorInterceptorWrapper extends InterceptorsWrapper {
  final SimpleNotify notifier;

  ErrorInterceptorWrapper({
    required this.notifier,
  });

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (err.requestOptions.extra["needFeedback"] == true) {
      notifier.show("에러코드 ${err.response?.statusCode}: ${err.message}");
    }
    if (!kReleaseMode) {
      FirebaseCrashlytics.instance.recordError(
        err,
        StackTrace.current,
        reason: "DioException",
      );
    }
    super.onError(err, handler);
  }
}
