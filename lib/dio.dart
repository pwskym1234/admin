
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchVideoList(String type, int offset, int limit) async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/video/list',
        queryParameters: {
          'type': type,
          'offset': offset,
          'limit': limit,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Error fetching video list: $e');
    }
  }

  Future<dynamic> fetchVideoDetails(int videoId) async {
    try {
      final response = await _dio.get(
        'https://a-zit.tv/api/v1/video',
        queryParameters: {
          'video_id': videoId,
        },
      );
      return response.data;
    } catch (e) {
      throw Exception('Error fetching video details: $e');
    }
  }
}

