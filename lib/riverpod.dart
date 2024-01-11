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
    print("getVideos 메소드가 호출되었습니다.");
    try {
      final videos = await _apiService.fetchVideoList(type, offset, limit);
      state = videos;
      print("API 호출이 성공적으로 완료되었습니다.");
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