import 'package:admin/data/enum/video_type.dart';
import 'package:admin/data/model/panel.dart';
import 'package:admin/data/model/video.dart';
import 'package:admin/data/model/video_tag.dart';
import 'package:admin/data/api/dio_api.dart';
import 'package:admin/data/extension/dio_response_x.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final serverApiServiceProvider = Provider<ServerApiService>((ref) {
  return ServerApiService();
});

class ServerApiService {
  final DioApi api = DioApi();

  Future<List<Video>> fetchVideoList({
    required int offset,
    required int limit,
    required VideoType type,
  }) async {
    final queryParameters = {
      'offset': offset,
      'limit': limit,
      'type': type.serverKey,
    };

    try {
      final res =
          await api.get('/video/list', queryParameters: queryParameters);
      final videos = res.data.map<Video>((e) {
        // JSON 파싱 로그 추가 (Video.fromJson 내부에서도 유사하게 추가해야 함)
        return Video.fromJson(e);
      }).toList();
      return videos;
    } catch (e) {
      // 예외 처리 및 오류 로깅
      print('Error fetching video list: $e');
      return [];
    }
  }

  Future<List<Video>> fetchUntaggedVideoList(
      {required int offset,
      required int limit,
      required VideoType type,
      required String tagAdded}) async {
    final queryParameters = {
      'offset': offset,
      'limit': limit,
      'type': type.serverKey,
      'tag_added': tagAdded,
    };

    final res = await api.get('/video/admin', queryParameters: queryParameters);

    return res.data.map<Video>((e) => Video.fromJson(e)).toList();
  }

  Future<Video> fetchVideoDetails({
    required int videoId,
  }) async {
    final queryParameters = {
      'id': videoId,
    };

    final res = await api.get('/video', queryParameters: queryParameters);

    return Video.fromJson(res.data);
  }

  Future<List<Panel>> fetchPanelList(
      {required int politicalType,
      required int offset,
      required int limit}) async {
    final queryParameters = {
      'political_type': politicalType,
      'offset': offset,
      'limit': limit
    };

    final res = await api.get('/panel/list', queryParameters: queryParameters);

    return res.data.map<Panel>((e) => Panel.fromJson(e)).toList();
  }

  Future<bool> addPanelToVideo(
      {required int videoId, required int panelId}) async {
    try {
      final res = await api.post("/video/panel/create", data: {
        'video': videoId,
        'panel': panelId,
      });

      if (!res.isOk) {
        // 실패한 경우 로그 출력
        print("Failed to add panel to video. Response: ${res.data}");
        return false;
      }

      return true;
    } catch (e) {
      // 예외 발생 시 로그 출력
      print("Exception occurred while adding panel to video: $e");
      return false;
    }
  }

  Future<bool> removePanelFromVideo(
      {required int videoId, required int panelId}) async {
    final res = await api.post("/video/panel/delete", data: {
      'video': videoId,
      'panel': panelId,
    });
    return res.isOk;
  }

  Future<List<VideoTag>> fetchLiveTagList() async {
    final res = await api.get('/tag/list');

    return res.data.map<VideoTag>((e) => VideoTag.fromJson(e)).toList();
  }

  Future<bool> addTagToVideo({required int videoId, required int tagId}) async {
    final res = await api.post("/video/tag/create", data: {
      'video': videoId,
      'tag': tagId,
    });
    return res.isOk;
  }

  Future<bool> removeTagFromVideo(
      {required int videoId, required int tagId}) async {
    final res = await api.post("/video/tag/delete", data: {
      'video': videoId,
      'tag': tagId,
    });
    return res.isOk;
  }

  Future<List<VideoTag>> fetchTagList() async {
    final res = await api.get('/tag/admin');

    return res.data.map<VideoTag>((e) => VideoTag.fromJson(e)).toList();
  }

  Future<dynamic> createTag(String tagName) async {
    final res = await api.post("/tag/create", data: {'name': tagName});
    return VideoTag.fromJson(res.data);
  }

  Future<dynamic> deleteTag(int tagId) async {
    final res = await api.post(
      '/tag/delete',
      queryParameters: {
        'id': tagId,
      },
      data: {'admin_password': 'g_hole_admin'},
    );
    return res.data;
  }

  Future<dynamic> createPanel(
      {required String panelName,
      required int politicalTypeId,
      required List<int>? imageByte,
      required String? fileName}) async {
    Map<String, dynamic> data = {
      'name': panelName,
      'political_type': politicalTypeId,
    };

    if (imageByte != null && fileName != null) {
      data.putIfAbsent('thumbnail_url',
          () => MultipartFile.fromBytes(imageByte, filename: fileName));
    }

    final res = await api.post("/panel/create", data: {FormData.fromMap(data)});
    return Panel.fromJson(res.data);
  }
}
