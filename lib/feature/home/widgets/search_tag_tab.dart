import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';
import 'package:admin/data/apiservice.dart';

class SearchTagTab extends ConsumerWidget {
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
            decoration: InputDecoration(
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
                    return Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: tagDataList.length,
                          itemBuilder: (context, index) {
                            final tagData = tagDataList[index];
                            return ListTile(
                              title: Text(tagData['name'].toString()),
                            );
                          },
                        ));
                  } else {
                    return Center(
                      child: Text('결과가 없습니다.'),
                    );
                  }
                },
                loading: () => CircularProgressIndicator(),
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

  Future<List<dynamic>> _fetchAndFilterTagList(WidgetRef ref) async {
    final searchQuery = ref.read(searchTagQueryProvider.notifier).state ?? "";
    final apiService = ref.read(apiServiceProvider);
    final tagList = await apiService.fetchTagList();

    return searchQuery.isNotEmpty
        ? tagList
            .where(
                (tagData) => tagData['name'].toString().contains(searchQuery))
            .toList()
        : tagList;
  }
}
