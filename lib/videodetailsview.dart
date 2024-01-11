import 'package:flutter/material.dart';
import 'package:admin/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
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
        var youtubeUrl = videoData['youtube_link'];
        var youtubeId = YoutubePlayer.convertUrlToId(youtubeUrl);
        print(videoData['title']);


        return youtubeId != null
            ? Container(
  width: 600, // 원하는 너비
  height: 1000,


  child: YoutubePlayerBuilder(
    player: YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: youtubeId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      ),
    ),
    builder: (context, player) => Column(
      children: [
        Text(videoData['title'],
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        player,
        SearchTab()
        

        // 다른 필요한 데이터를 여기에 추가합니다.
      ],
    ),
  ),
)

            : Text('Invalid YouTube URL');
      },
    );
  }
}
