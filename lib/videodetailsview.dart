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
        var panels = videoData['panels'] as List<dynamic>;

        var youtubeUrl = videoData['youtube_link'];
        final youtubeId = YoutubePlayerController.convertUrlToId(youtubeUrl);

        if (youtubeId == null) {
          return const Text('Invalid YouTube URL');
        }

        final _controller = YoutubePlayerController.fromVideoId(
          videoId: youtubeId,
          autoPlay: false,
          params: const YoutubePlayerParams(showFullscreenButton: true),
        );

        return SizedBox(
            width: 600, // 원하는 너비

            child: YoutubePlayerControllerProvider(
              controller: _controller,
              child: Builder(
                builder: (context) => Column(
                  children: [
                    Text(
                      videoData['title'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    YoutubePlayer(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                    SearchTab(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: panels.length,
                      itemBuilder: (context, index) {
                        final panel = panels[index];
                        return ListTile(
                          title: Text(panel['name']),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () async {
                              await ref
                                  .read(apiServiceProvider)
                                  .removePanelFromVideo(videoId, panel['id']);
                              // UI 업데이트를 위해 필요한 로직을 추가합니다.
                              // 예: 상태 업데이트 또는 새로운 데이터로 FutureBuilder를 다시 빌드합니다.
                            },
                          ),
                        );
                      },
                    ),

                    // 다른 필요한 데이터를 여기에 추가합니다.
                  ],
                ),
              ),
            ));
      },
    );
  }
}
