import 'package:flutter/material.dart';
import 'package:admin/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class VideoDetailsView extends ConsumerWidget {
  final int videoId;

  VideoDetailsView({required this.videoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoId = ref.watch(selectedVideoIdProvider);

    if (videoId == null) {
      return Center(child: Text('Select a video'));
    }


    return FutureBuilder(
      future: ref.read(apiServiceProvider).fetchVideoDetails(videoId),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return Text('No data available');
        }

        var videoData = snapshot.data;
        return Column(
          children: [
            Image.network(videoData['thumbnail_url']),
            Text(videoData['title']),
            // 다른 필요한 데이터를 여기에 추가합니다.
          ],
        );
      },
    );
  }
}
