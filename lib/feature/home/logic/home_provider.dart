import 'package:admin/data/enum/video_type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/data/model/panel.dart';
import 'package:admin/data/service/server_api_service.dart';
import 'package:admin/data/model/video_tag.dart';

final videoListProvider =
    StateNotifierProvider<VideoListNotifier, List<dynamic>>((ref) {
  return VideoListNotifier(ref);
});

class VideoListNotifier extends StateNotifier<List<dynamic>> {
  VideoListNotifier(this.ref) : super([]);

  final Ref ref;
  ServerApiService get _apiService => ref.read(serverApiServiceProvider);

  Future<void> getVideos(VideoType type, int offset, int limit) async {
    try {
      final videos = await _apiService.fetchVideoList(
          limit: limit, offset: offset, type: type);
      state = videos;
    } catch (e) {
      print("API 호출 중 오류가 발생했습니다: $e");

      state = [];
    }
  }
}

final untaggedVideoListProvider =
    StateNotifierProvider<UntaggedVideoListNotifier, List<dynamic>>((ref) {
  return UntaggedVideoListNotifier(ref);
});

class UntaggedVideoListNotifier extends StateNotifier<List<dynamic>> {
  UntaggedVideoListNotifier(this.ref) : super([]);

  final Ref ref;
  ServerApiService get _apiService => ref.read(serverApiServiceProvider);

  Future<void> getUntaggedVideos(
      VideoType type, String tagAdded, int offset, int limit) async {
    try {
      final videos = await _apiService.fetchUntaggedVideoList(
          type: type, tagAdded: tagAdded, offset: offset, limit: limit);
      state = videos;
    } catch (e) {
      print("API 호출 중 오류가 발생했습니다: $e");
      state = [];
    }
  }
}

final selectedVideoIdProvider = StateProvider<int?>((ref) => null);

final searchPanelQueryProvider = StateProvider<String?>((ref) => null);

final panelListProvider = FutureProvider<List<Panel>>((ref) async {
  final searchQuery = ref.watch(searchPanelQueryProvider);
  final apiService = ref.read(serverApiServiceProvider);

  try {
    final responses = await Future.wait([
      apiService.fetchPanelList(politicalType: 1, offset: 0, limit: 1000),
      apiService.fetchPanelList(politicalType: 2, offset: 0, limit: 1000),
      apiService.fetchPanelList(politicalType: 3, offset: 0, limit: 1000),
    ]);
    // final responseLengths =
    //     responses.map((response) => response.length).toList();
    // print('각 응답 데이터의 길이: $responseLengths');

    final panelList = responses.expand((x) => x).toList();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      List<Panel> filteredPanels =
          panelList.where((panel) => panel.name.contains(searchQuery)).toList();

      return filteredPanels;
      // .where((panelData) => panelData['name'].contains(searchQuery))
      // .toList();
    } else {
      return panelList;
    }
  } catch (e) {
    throw Exception('패널 목록 불러오기 실패: $e');
  }
});

final searchTagQueryProvider = StateProvider<String?>((ref) => null);

final searchVideoQueryProvider = StateProvider<String?>((ref) => null);

final tagListProvider = FutureProvider<List<dynamic>>((ref) async {
  final searchQuery = ref.watch(searchTagQueryProvider);
  final apiService = ref.read(serverApiServiceProvider);

  try {
    final tagList = await apiService.fetchTagList();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      List<VideoTag> filteredTags =
          tagList.where((tag) => tag.name.contains(searchQuery)).toList();

      return filteredTags;
    } else {
      return tagList;
    }
  } catch (e) {
    throw Exception('태그 목록 불러오기 실패: $e');
  }
});
