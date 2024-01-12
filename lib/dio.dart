import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchUntaggedVideoList(
      String type, String tag_added, int offset, int limit) async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/video/admin',
        queryParameters: {
          'type': type,
          'tag_added': tag_added,
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

  Future<List<dynamic>> fetchTagList() async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/tag/list',
        queryParameters: {},
      );
      return response.data;
    } catch (e) {
      throw Exception('Error fetching tag list: $e');
    }
  }

  Future<void> addTagToVideo(int videoId, int tagId) async {
    final response =
        await _dio.post('https://a-zit.tv/api/v1/video/tag/create', data: {
      'video': videoId,
      'tag': tagId,
    });

    if (response.statusCode == 200) {
      print('Tag added successfully');
    } else {
      print('Failed to add tag');
    }
  }

  Future<void> removeTagFromVideo(int videoId, int tagId) async {
    try {
      final response = await _dio.post(
        'https://a-zit.tv/api/v1/video/tag/delete',
        data: {
          'video': videoId,
          'tag': tagId,
        },
      );

      if (response.statusCode == 200) {
        print('Tag successfully removed');
      } else {
        print('Failed to remove tag');
      }
    } catch (e) {
      print('Exception occurred while removing tag: $e');
      throw Exception('Exception occurred while removing tag: $e');
    }
  }
}
