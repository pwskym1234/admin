import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/dio.dart';

final videoListProvider =
    StateNotifierProvider<VideoListNotifier, List<dynamic>>((ref) {
  return VideoListNotifier(ref);
});

class VideoListNotifier extends StateNotifier<List<dynamic>> {
  VideoListNotifier(this.ref) : super([]);

  final Ref ref;
  ApiService get _apiService => ref.read(apiServiceProvider);

  Future<void> getVideos(String type, int offset, int limit) async {
    try {
      final videos = await _apiService.fetchVideoList(type, offset, limit);
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
  ApiService get _apiService => ref.read(apiServiceProvider);

  Future<void> getUntaggedVideos(
      String type, String tag_added, int offset, int limit) async {
    try {
      final videos = await _apiService.fetchUntaggedVideoList(
          type, tag_added, offset, limit);
      state = videos;
    } catch (e) {
      print("API 호출 중 오류가 발생했습니다: $e");
      state = [];
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final selectedVideoIdProvider = StateProvider<int?>((ref) => null);

final searchPanelQueryProvider = StateProvider<String?>((ref) => null);

final panelListProvider = FutureProvider<List<dynamic>>((ref) async {
  final searchQuery = ref.watch(searchPanelQueryProvider);
  final apiService = ref.read(apiServiceProvider); // ApiService 인스턴스 가져오기

  try {
    final responses = await Future.wait([
      apiService.fetchPanelList(1),
      apiService.fetchPanelList(2),
      apiService.fetchPanelList(3),
    ]);

    final panelList = responses.expand((x) => x).toList();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      // 검색어를 사용하여 필터링
      return panelList
          .where(
              (panelData) => panelData['name'].toString().contains(searchQuery))
          .toList();
    } else {
      return panelList;
    }
  } catch (e) {
    throw Exception('패널 목록 불러오기 실패: $e');
  }
});

final searchTagQueryProvider = StateProvider<String?>((ref) => null);

final tagListProvider = FutureProvider<List<dynamic>>((ref) async {
  final searchQuery = ref.watch(searchTagQueryProvider);
  final apiService = ref.read(apiServiceProvider);

  try {
    final tagList = await apiService.fetchTagList();

    if (searchQuery != null && searchQuery.isNotEmpty) {
      return tagList
          .where((tagData) => tagData['name'].toString().contains(searchQuery))
          .toList();
    } else {
      return tagList;
    }
  } catch (e) {
    throw Exception('태그 목록 불러오기 실패: $e');
  }
});

final selectedCategoryIdProvider = StateProvider<int?>((ref) => null);





// final panelListProvider = FutureProvider<List<dynamic>>((ref) async {
//   final searchQuery = ref.watch(searchQueryProvider);
  
//   if (response.statusCode == 200) {
//     final panelDataList = List<dynamic>.from(response.data);
//     if (searchQuery != null && searchQuery.isNotEmpty) {
//       // 검색어를 사용하여 필터링
//       return panelDataList
//           .where((panelData) =>
//               panelData['name'].toString().contains(searchQuery))
//           .toList();
//     } else {
//       return panelDataList;
//     }
//   } else {
//     throw Exception('Failed to load panel list');
//   }
// });
