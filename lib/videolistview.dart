import 'package:admin/videodetailsview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/riverpod.dart';

class VideoListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoListNotifier = ref.read(videoListProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      videoListNotifier.getVideos('LIVE', 0, 10);
    });

    final videoList = ref.watch(videoListProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '라이브 영상 리스트', // 여기에 원하는 제목을 입력하세요.
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(

          child: ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(videoList[index]['title']),
                onTap: () {
                  ref.read(selectedVideoIdProvider.state).state = videoList[index]['id'];
          
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
