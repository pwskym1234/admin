// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/data/api/apiservice.dart';

final selectedTagStatusIdProvider = StateProvider<int?>((ref) => null);

final selectedTagIdProvider = StateProvider<int?>((ref) => null);

final searchTagToUpdateQueryProvider = StateProvider<String?>((ref) => null);

final tagListToUpdateProvider =
    StateNotifierProvider<TagListNotifier, List<dynamic>>((ref) {
  return TagListNotifier(ref);
});

class TagListNotifier extends StateNotifier<List<dynamic>> {
  TagListNotifier(this.ref) : super([]);

  final Ref ref;
  ApiService get _apiService => ref.read(apiServiceProvider);

  Future<void> getTags() async {
    try {
      final tags = await _apiService.fetchTagList();
      state = tags;
    } catch (e) {
      state = [];
    }
  }
}

final searchBarTagListProvider = FutureProvider<List<dynamic>>((ref) async {
  final searchQuery = ref.watch(searchTagToUpdateQueryProvider);
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
