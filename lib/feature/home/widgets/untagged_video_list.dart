import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';

class UntaggedVideoList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final untaggedVideoListNotifier =
        ref.read(untaggedVideoListProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      untaggedVideoListNotifier.getUntaggedVideos('VIDEO', 'false', 0, 10);
    });

    final videoList = ref.watch(untaggedVideoListProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '태그가 필요한 영상 리스트', // 여기에 원하는 제목을 입력하세요.
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              final item = videoList[index];
              return ListTile(
                title: Text(item['title']),
                onTap: () {
                  ref.read(selectedVideoIdProvider.notifier).state = item['id'];
                  print(item['id']);
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