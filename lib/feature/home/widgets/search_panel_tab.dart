import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';
import 'package:admin/data/apiservice.dart';

class SearchPanelTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (query) {
              ref.read(searchPanelQueryProvider.notifier).state = query;
            },
            decoration: const InputDecoration(
              labelText: '패널 검색',
              hintText: '패널을 입력하세요',
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

  Future<List<dynamic>> _fetchAndFilterPanelList(WidgetRef ref) async {
    final searchQuery = ref.read(searchPanelQueryProvider.notifier).state ?? "";
    final apiService = ref.read(apiServiceProvider);
    final responses = await Future.wait([
      apiService.fetchPanelList(1),
      apiService.fetchPanelList(2),
      apiService.fetchPanelList(3),
    ]);
    final panelList = responses.expand((x) => x).toList();

    return searchQuery.isNotEmpty
        ? panelList
            .where((panelData) =>
                panelData['name'].toString().contains(searchQuery))
            .toList()
        : panelList;
  }
}