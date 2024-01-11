import 'package:flutter/material.dart';
import 'package:admin/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:admin/searchtab.dart';

class VideoDetailsView extends ConsumerWidget {
  final int videoId;

  VideoDetailsView({required this.videoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoId = ref.watch(selectedVideoIdProvider);

    if (videoId == null) {
      return const Center(child: Text('Select a video'));
    }

    return FutureBuilder(
      future: ref.read(apiServiceProvider).fetchVideoDetails(videoId),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Text('No data available');
        }

        var videoData = snapshot.data;
        var youtubeUrl = videoData['youtube_link'];
        final youtubeId = YoutubePlayerController.convertUrlToId(youtubeUrl);

        if (youtubeId == null) {
          return const Text('Invalid YouTube URL');
        }

        var controller = YoutubePlayerController(
          initialVideoId: youtubeId,
          params: YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: true,
            // 다른 YouTube IFrame 파라미터 추가
          ),
        );

        return YoutubePlayerControllerProvider(
          controller: controller,
          child: YoutubePlayerScaffold(
            controller: controller,
            builder: (context, player) => SizedBox(
              width: 600, // 원하는 너비
              child: Column(
                children: [
                  Text(
                    videoData['title'],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  player, // YoutubePlayerIFrame 대신 이렇게 사용
                  SearchTab()
                  // 여기에 다른 위젯 추가
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
