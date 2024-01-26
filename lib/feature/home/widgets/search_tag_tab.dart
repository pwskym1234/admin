import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';

class SearchTagTab extends ConsumerWidget {
  final Function(int id) onDelete;

  const SearchTagTab({
    Key? key,
    required this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (query) {
              ref.read(searchTagQueryProvider.notifier).state = query;
            },
            decoration: const InputDecoration(
              labelText: '태그 검색',
              hintText: '태그를 입력하세요',
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final tagListAsyncValue = ref.watch(tagListProvider);

              return tagListAsyncValue.when(
                data: (tagDataList) {
                  if (tagDataList.isNotEmpty) {
                    return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: tagDataList.length,
                          itemBuilder: (context, index) {
                            final tagData = tagDataList[index];
                            return ListTile(
                              title: Text(tagData['name'].toString()),
                              trailing: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () async {
                                    try {
                                      await onDelete(tagData['id']);
                                      // ignore: unused_result
                                      ref.refresh(tagListProvider);
                                    } catch (e) {
                                      debugPrint('Error deleting tag: $e');
                                    }
                                  }),
                            );
                          },
                        ));
                  } else {
                    return const Center(
                      child: Text('결과가 없습니다.'),
                    );
                  }
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) {
                  return Center(
                    child: Text('오류: $error'),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // Future<List<dynamic>> _fetchAndFilterTagList(WidgetRef ref) async {
  //   final searchQuery = ref.read(searchTagQueryProvider.notifier).state ?? "";
  //   final apiService = ref.read(apiServiceProvider);
  //   final tagList = await apiService.fetchLiveTagList();

  //   return searchQuery.isNotEmpty
  //       ? tagList
  //           .where(
  //               (tagData) => tagData['name'].toString().contains(searchQuery))
  //           .toList()
  //       : tagList;
  // }
}
