import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/riverpod.dart';
import 'package:admin/dio.dart';

class SearchTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (query) {
              ref.read(searchQueryProvider.notifier).state = query;
            },
            decoration: InputDecoration(
              labelText: '검색',
              hintText: '검색어를 입력하세요',
              suffixIcon: TextButton(
                onPressed: () {
                  // 여기에 버튼이 눌렸을 때 수행할 로직을 넣습니다
                  final searchQuery =
                      ref.read(searchQueryProvider.notifier).state;
                  final panelListAsyncValue = ref.watch(panelListProvider);

                  panelListAsyncValue.when(
                    data: (panelList) {
                      final matchingPanel = panelList.firstWhere(
                        (panel) => panel['name'].toString() == searchQuery,
                        orElse: () => null,
                      );
                      final videoId = ref.watch(selectedVideoIdProvider);

                      if (matchingPanel != null && videoId != null) {
                        ref
                            .read(apiServiceProvider)
                            .addPanelToVideo(videoId, matchingPanel['id']);
                      }
                    },
                    loading: () {
                      // 로딩 처리
                    },
                    error: (e, stack) {
                      // 에러 처리
                    },
                  );
                },
                child: Text(
                  '추가',
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final panelListAsyncValue = ref.watch(panelListProvider);

              return panelListAsyncValue.when(
                data: (panelDataList) {
                  if (panelDataList.isNotEmpty) {
                    return Container(
                        height: 100,
                        child: ListView.builder(
                          itemCount: panelDataList.length,
                          itemBuilder: (context, index) {
                            final panelData = panelDataList[index];
                            return ListTile(
                              title: Text(panelData['name'].toString()),
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

  Future<List<dynamic>> _fetchAndFilterPanelList(WidgetRef ref) async {
    final searchQuery = ref.read(searchQueryProvider.notifier).state ?? "";
    final apiService = ref.read(apiServiceProvider);
    final panelList =
        await apiService.fetchPanelList(1); // 'political_type' 실제 값으로 변경 필요

    return searchQuery.isNotEmpty
        ? panelList
            .where((panelData) =>
                panelData['name'].toString().contains(searchQuery))
            .toList()
        : panelList;
  }
}
