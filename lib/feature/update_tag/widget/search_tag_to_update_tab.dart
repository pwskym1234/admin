import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/update_tag/logic/update_tag_controller.dart';

class SearchTagToUpdateTab extends ConsumerWidget {
  const SearchTagToUpdateTab({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (query) {
              ref.read(searchTagToUpdateQueryProvider.notifier).state = query;
            },
            decoration: const InputDecoration(
              labelText: '태그 검색',
              hintText: '태그를 입력하세요',
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final tagListAsyncValue = ref.watch(searchBarTagListProvider);

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
}
