import 'package:dio/dio.dart';
// import 'package:politic_2024/app/data/api/auth_interceptor_wrapper.dart';
import 'error_interceptor_wrapper.dart';
// import 'package:politic_2024/app/data/service/auth_service.dart';
// import 'package:politic_2024/app/data/service/storage_service.dart';
import 'package:admin/ui/e_simple_notify.dart';

class DioApi {
  DioApi() : dio = Dio() {
    dio.interceptors.addAll([
      // AuthInterceptorWrapper(
      //   storage: StorageService.to,
      //   auth: AuthService.to,
      //   dio: dio,
      // ),
      ErrorInterceptorWrapper(
        notifier: SimpleNotify(),
      ),
    ]);
  }

  final Dio dio;
  static const _host = "https://a-zit.tv/api/v1";

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool needFeedback = true,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.get(
      _host + path,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: Options(extra: {"needFeedback": needFeedback}),
    );

    return _handleException(response);
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    required dynamic data,
    bool needFeedback = true,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.post(
      _host + path,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      options: Options(extra: {"needFeedback": needFeedback}),
    );

    return _handleException(response);
  }

  Future<Response> delete(
    String path, {
    bool needFeedback = true,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.delete(
      _host + path,
      cancelToken: cancelToken,
      options: Options(extra: {"needFeedback": needFeedback}),
    );

    return _handleException(response);
  }

  Future<Response> put(
    String path, {
    required dynamic data,
    bool needFeedback = true,
    CancelToken? cancelToken,
  }) async {
    final response = await dio.put(
      _host + path,
      data: data,
      cancelToken: cancelToken,
      options: Options(extra: {"needFeedback": needFeedback}),
    );
    return _handleException(response);
  }

  // Future<Response> getCategoryVideos(String categoryName) async {
  //   return get("/videos?category=$categoryName");
  // }

  Response<dynamic> _handleException(Response<dynamic> response) {
    return response;
  }
}
