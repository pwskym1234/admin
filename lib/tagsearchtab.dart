import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/riverpod.dart';
import 'package:admin/dio.dart';

class TagSearchTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchTagQueryProvider);

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
              // suffixIcon: TextButton(
              //   onPressed: () {
              //     // 여기에 버튼이 눌렸을 때 수행할 로직을 넣습니다
              //     // final searchQuery =
              //     //     ref.read(searchQueryProvider.notifier).state;
              //     // final panelListAsyncValue = ref.watch(panelListProvider);

              //     // panelListAsyncValue.when(
              //     //   data: (panelList) {
              //     //     final matchingPanel = panelList.firstWhere(
              //     //       (panel) => panel['name'].toString() == searchQuery,
              //     //       orElse: () => null,
              //     //     );
              //     //     final videoId = ref.watch(selectedVideoIdProvider);

              //     //     if (matchingPanel != null && videoId != null) {
              //     //       ref
              //     //           .read(apiServiceProvider)
              //     //           .addPanelToVideo(videoId, matchingPanel['id']);
              //     //     }
              //     //   },
              //     //   loading: () {
              //     //     // 로딩 처리
              //     //   },
              //     //   error: (e, stack) {
              //     //     // 에러 처리
              //     //   },
              //     // );
              //   },
              //   child: Text(
              //     '추가',
              //     style: TextStyle(color: Colors.white),
              //   ),
              //   style: TextButton.styleFrom(
              //     backgroundColor: Colors.black,
              //   ),
              // ),
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
