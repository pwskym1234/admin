import 'package:admin/tagsearchtab.dart';
import 'package:flutter/material.dart';
import 'package:admin/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:admin/panelsearchtab.dart';
import 'package:admin/listitemview.dart';
import 'package:admin/custombutton.dart';

class VideoDetailsView extends ConsumerStatefulWidget {
  final int videoId;

  VideoDetailsView({required this.videoId});

  @override
  ConsumerState<VideoDetailsView> createState() => VideoDetailsViewState();
}

class VideoDetailsViewState extends ConsumerState<VideoDetailsView> {
  late Future<dynamic> videoDetailsFuture;
  List<dynamic> panels = [];
  List<dynamic> tags = [];
  @override
  void initState() {
    super.initState();
    videoDetailsFuture = fetchVideoDetails();
  }

  Future<dynamic> fetchVideoDetails() async {
    var videoDetails =
        await ref.read(apiServiceProvider).fetchVideoDetails(widget.videoId);

    panels = videoDetails['panels'] != null
        ? videoDetails['panels'] as List<dynamic>
        : [];

    panels = videoDetails['tags'] != null
        ? videoDetails['tags'] as List<dynamic>
        : [];

    return videoDetails;
  }

  Future<void> addPanel(int panelId, String panelName) async {
    await ref.read(apiServiceProvider).addPanelToVideo(widget.videoId, panelId);
    setState(() {
      var newPanel = {
        'id': panelId,
        'name': panelName,
      };
      panels.add(newPanel);
    });
  }

  Future<void> removePanel(int panelId) async {
    await ref
        .read(apiServiceProvider)
        .removePanelFromVideo(widget.videoId, panelId);
    setState(() {
      panels.removeWhere((panel) => panel['id'] == panelId);
    });
  }

  Future<void> addTag(String tagName) async {
    try {
      final tagListAsyncValue = ref.watch(tagListProvider);

      bool tagExists = false;
      await tagListAsyncValue.whenData((tagList) {
        tagExists = tagList.any((tag) => tag['name'] == tagName);
      });

      int tagId;
      if (!tagExists) {
        var newTag = await ref.read(apiServiceProvider).createTag(tagName);
        tagId = newTag['id'];
      } else {
        tagId = tagListAsyncValue.value!.firstWhere(
          (tag) => tag['name'] == tagName,
          orElse: () => throw Exception('Tag not found'),
        )['id'];
      }

      await ref.read(apiServiceProvider).addTagToVideo(widget.videoId, tagId);
      setState(() {
        tags.add({
          'id': tagId,
          'name': tagName,
        });
      });
    } catch (e) {
      print('Error adding tag: $e');
    }
  }

  Future<void> removeTag(int tagId) async {
    await ref
        .read(apiServiceProvider)
        .removeTagFromVideo(widget.videoId, tagId);
    setState(() {
      tags.removeWhere((tag) => tag['id'] == tagId);
    });
  }

  @override
  Widget build(BuildContext context) {
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
        var panels = videoData['panels'] as List<dynamic>;
        var tags = videoData['tags'] as List<dynamic>;

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

        return YoutubePlayerControllerProvider(
          controller: _controller,
          child: Builder(
            builder: (context) => Column(
              children: [
                Text(
                  videoData['title'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 600,
                      child: YoutubePlayer(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 330,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListItemView(
                                items: panels,
                                onRemove: (id) => removePanel(id),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: ListItemView(
                                items: tags,
                                onRemove: (id) => removeTag(id),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: PanelSearchTab()),
                    CustomButton(
                      text: '추가',
                      onPressed: () async {
                        final searchQuery =
                            ref.read(searchPanelQueryProvider.notifier).state;

                        if (searchQuery != null && searchQuery.isNotEmpty) {
                          final videoId = ref.watch(selectedVideoIdProvider);

                          if (videoId != null) {
                            final panelListAsyncValue =
                                ref.watch(panelListProvider);

                            await panelListAsyncValue
                                .whenData((panelList) async {
                              final matchingPanel = panelList.firstWhere(
                                (panel) =>
                                    panel['name'].toString() == searchQuery,
                                orElse: () => null,
                              );

                              if (matchingPanel != null) {
                                await addPanel(
                                    matchingPanel['id'], matchingPanel['name']);
                              } else {}
                            });
                          }
                        }
                      },
                    ),
                    Expanded(child: TagSearchTab()),
                    CustomButton(
                      text: '추가',
                      onPressed: () async {
                        final searchQuery =
                            ref.read(searchTagQueryProvider.notifier).state;

                        if (searchQuery != null && searchQuery.isNotEmpty) {
                          final videoId = ref.watch(selectedVideoIdProvider);

                          if (videoId != null) {
                            await addTag(searchQuery);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
