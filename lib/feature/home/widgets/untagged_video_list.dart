import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';
import 'search_untagged_video_tab.dart';

class UntaggedVideoList extends ConsumerWidget {
  const UntaggedVideoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final untaggedVideoListNotifier =
        ref.read(untaggedVideoListProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      untaggedVideoListNotifier.getUntaggedVideos('VIDEO', 'false', 0, 500);
    });

    final videoList = ref.watch(untaggedVideoListProvider);
    final searchVideoQuery = ref.watch(searchVideoQueryProvider) ?? '';

    final filteredVideoList = videoList.where((video) {
      return video['title'].contains(searchVideoQuery) ||
          (video.containsKey('description') &&
              video['description'].contains(searchVideoQuery));
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '태그가 필요한 영상 리스트', // 여기에 원하는 제목을 입력하세요.
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        const SearchUntaggedVideoTab(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredVideoList.length,
            itemBuilder: (context, index) {
              final item = filteredVideoList[index];
              return ListTile(
                title: Text(item['title']),
                onTap: () {
                  ref.read(selectedVideoIdProvider.notifier).state = item['id'];

                  // 아이템 탭에 대한 액션을 여기에 추가하세요.
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
