// ignore_for_file: non_constant_identifier_names

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

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
      debugPrint('Error fetching video list: $e');
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
      debugPrint('Error fetching video list: $e');
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

  Future<List<dynamic>> fetchPanelList(
      int political_type, int offset, int limit) async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/panel/list',
        queryParameters: {
          'political_type': political_type,
          'offset': offset,
          'limit': limit
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
      debugPrint('Panel added successfully');
    } else {
      debugPrint('Failed to add panel');
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
        debugPrint('Panel successfully removed');
      } else {
        debugPrint('Failed to remove panel');
      }
    } catch (e) {
      debugPrint('Exception occurred while removing panel: $e');
      throw Exception('Exception occurred while removing panel: $e');
    }
  }

  Future<List<dynamic>> fetchLiveTagList() async {
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
      debugPrint('Tag added successfully');
    } else {
      debugPrint('Failed to add tag');
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
        debugPrint('Tag successfully removed');
      } else {
        debugPrint('Failed to remove tag');
      }
    } catch (e) {
      debugPrint('Exception occurred while removing tag: $e');
      throw Exception('Exception occurred while removing tag: $e');
    }
  }

  Future<List<dynamic>> fetchTagList() async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/tag/admin',
        queryParameters: {},
      );
      return response.data;
    } catch (e) {
      throw Exception('Error fetching tag list: $e');
    }
  }

  Future<dynamic> createTag(String tagName) async {
    try {
      final response = await _dio.post(
        'https://a-zit.tv/api/v1/tag/create',
        data: {'name': tagName},
      );

      if (response.statusCode == 201) {
        debugPrint('Tag created successfully: ${response.data}');
        return response.data;
      } else {
        debugPrint('Failed to create tag');
        throw Exception('Failed to create tag');
      }
    } catch (e) {
      debugPrint('Exception occurred while creating tag: $e');
      throw Exception('Exception occurred while creating tag: $e');
    }
  }

  Future<dynamic> createPanel(String panelName, int politicalTypeId,
      List<int>? imageByte, String? fileName) async {
    try {
      Map<String, dynamic> data = {
        'name': panelName,
        'political_type': politicalTypeId,
      };
      if (imageByte != null && fileName != null) {
        data.putIfAbsent('thumbnail_url',
            () => MultipartFile.fromBytes(imageByte, filename: fileName));
      }
      final response = await _dio.post('https://a-zit.tv/api/v1/panel/create',
          data: FormData.fromMap(data));

      if (response.statusCode == 201) {
        debugPrint('Panel created successfully: ${response.data}');
        return response.data;
      } else {
        debugPrint('Failed to create panel');
        throw Exception('Failed to create panel');
      }
    } catch (e) {
      debugPrint('Exception occurred while creating panel: $e');
      throw Exception('Exception occurred while creating panel: $e');
    }
  }

  Future<dynamic> deleteTag(int tagId) async {
    try {
      final response = await _dio.post(
        'https://a-zit.tv/api/v1/tag/delete',
        queryParameters: {
          'id': tagId,
        },
        data: {'admin_password': 'g_hole_admin'},
      );

      if (response.statusCode == 200) {
        debugPrint('Tag deleted successfully: ${response.data}');
        return response.data;
      } else {
        debugPrint('Failed to delete tag');
        throw Exception('Failed to delete tag');
      }
    } catch (e) {
      debugPrint('Exception occurred while deleting tag: $e');
      throw Exception('Exception occurred while deleting tag: $e');
    }
  }

  Future<dynamic> updateTag(int tagId, int status) async {
    try {
      final response = await _dio.put(
        'https://a-zit.tv/api/v1/tag?id=$tagId',
        data: {'status': status},
      );

      if (response.statusCode == 200) {
        debugPrint('Tag updated successfully: ${response.data}');
        return response.data;
      } else {
        debugPrint('Failed to update tag');
        throw Exception('Failed to update tag');
      }
    } catch (e) {
      debugPrint('Exception occurred while updating tag: $e');
      throw Exception('Exception occurred while updating tag: $e');
    }
  }
}
