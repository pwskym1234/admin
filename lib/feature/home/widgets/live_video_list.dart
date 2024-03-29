import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';

class LiveVideoList extends ConsumerWidget {
  const LiveVideoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoListNotifier = ref.read(videoListProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      videoListNotifier.getVideos('LIVE', 0, 30);
    });

    final videoList = ref.watch(videoListProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '라이브 영상 리스트', // 여기에 원하는 제목을 입력하세요.
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              final item = videoList[index];
              Color circleColor;

              // 여기에서 동그라미의 색을 결정합니다.
              bool panelsEmpty =
                  item['panels'] == null || item['panels'].isEmpty;
              bool tagsEmpty = item['tags'] == null || item['tags'].isEmpty;

              if (panelsEmpty && tagsEmpty) {
                circleColor = Colors.red;
              } else if (panelsEmpty || tagsEmpty) {
                circleColor = Colors.yellow;
              } else {
                circleColor = Colors.green;
              }

              return ListTile(
                title: Text(item['title']),
                trailing: CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 7, // 원하는 크기로 조절하세요.
                ),
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
