import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchVideoList(
      String type, int offset, int limit) async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/video/list',
        queryParameters: {
          'type': type,
          'offset': offset,
          'limit': limit,
        },
      );

      // print('API Response: ${response.data}');

      return response.data;
    } catch (e) {
      // 로깅: 예외 발생 시 출력
      print('Error fetching video list: $e');
      throw Exception('Error fetching video list: $e');
    }
  }

  Future<dynamic> fetchVideoDetails(int videoId) async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/video',
        queryParameters: {
          'id': videoId,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Error fetching video details: $e');
    }
  }

  Future<List<dynamic>> fetchPanelList(int political_type) async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/panel/list',
        queryParameters: {
          'political_type': political_type,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Error fetching panel list: $e');
    }
  }

  Future<void> addPanelToVideo(int videoId, int panelId) async {
    final response =
        await _dio.post('https://a-zit.tv/api/v1/video/panel/create', data: {
      'video': videoId,
      'panel': panelId,
    });

    if (response.statusCode == 200) {
      print('Panel added successfully');
    } else {
      print('Failed to add panel');
    }
  }

  Future<void> removePanelFromVideo(int videoId, int panelId) async {
    try {
      final response = await _dio.post(
        'https://a-zit.tv/api/v1/video/panel/delete',
        data: {
          'video': videoId,
          'panel': panelId,
        },
      );

      if (response.statusCode == 200) {
        print('Panel successfully removed');
      } else {
        print('Failed to remove panel');
      }
    } catch (e) {
      print('Exception occurred while removing panel: $e');
      throw Exception('Exception occurred while removing panel: $e');
    }
  }
}
