import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/dio.dart';

final videoListProvider = StateNotifierProvider<VideoListNotifier, List<dynamic>>((ref) {
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

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final selectedVideoIdProvider = StateProvider<int?>((ref) => null);