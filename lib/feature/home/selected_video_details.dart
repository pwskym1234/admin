import 'package:admin/feature/home/widgets/search_tag_tab.dart';
import 'package:flutter/material.dart';
import 'package:admin/feature/home/logic/home_controller.dart';
import 'package:admin/data/api/apiservice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:admin/feature/home/widgets/search_panel_tab.dart';
import 'package:admin/feature/home/widgets/selected_items_custom_list.dart';
import 'package:admin/feature/home/widgets/edit_custom_button.dart';
import 'package:admin/feature/create_panel/creat_panel_page.dart';
import 'package:admin/feature/home/logic/openai.dart';

class SelectedVideoDetails extends ConsumerStatefulWidget {
  final int videoId;

  SelectedVideoDetails({required this.videoId});

  @override
  ConsumerState<SelectedVideoDetails> createState() =>
      SelectedVideoDetailsState();
}

class SelectedVideoDetailsState extends ConsumerState<SelectedVideoDetails> {
  late Future<dynamic> videoDetailsFuture;

  List<dynamic> panels = [];
  List<dynamic> tags = [];

  late OpenAiTagGenerator tagGenerator;
  late OpenAiTagSuggester tagSuggester;
  @override
  void initState() {
    super.initState();
    videoDetailsFuture = fetchVideoDetails();
    String openAiApiKey = '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';
    tagGenerator = OpenAiTagGenerator(openAiApiKey);
    tagSuggester = OpenAiTagSuggester(openAiApiKey);
  }

  Future<dynamic> fetchVideoDetails() async {
    var videoDetails =
        await ref.read(apiServiceProvider).fetchVideoDetails(widget.videoId);

    panels = videoDetails['panels'] != null
        ? videoDetails['panels'] as List<dynamic>
        : [];

    tags = videoDetails['tags'] != null
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

  Future<void> addCreatedTagsToVideo(String videoTitle, int videoId,
      OpenAiTagGenerator tagGenerator, String videoDescription) async {
    Stopwatch stopwatch = Stopwatch()..start();
    List<String> createdTags =
        await tagGenerator.generateTags(videoTitle, videoDescription);

    for (var tag in createdTags) {
      try {
        var createdTag = await ref.read(apiServiceProvider).createTag(tag);
        int createdTagId = createdTag['id'];
        String createdTagName = createdTag['name'];

        await ref.read(apiServiceProvider).addTagToVideo(videoId, createdTagId);

        setState(() {
          tags.add({
            'id': createdTagId,
            'name': createdTagName,
          });
        });
      } catch (e) {
        print('Error adding tag "$tag": $e');
      }
    }
    stopwatch.stop();
    print('Time taken to add tags: ${stopwatch.elapsed.inMilliseconds} ms');
  }

  Future<void> removeTag(int tagId) async {
    await ref
        .read(apiServiceProvider)
        .removeTagFromVideo(widget.videoId, tagId);
    setState(() {
      tags.removeWhere((tag) => tag['id'] == tagId);
    });
  }

  Future<void> deleteTag(int tagId) async {
    await ref.read(apiServiceProvider).deleteTag(tagId);
  }

  Future<void> addMatchingTagsToVideo(
      String videoTitle, int videoId, String videoDescription) async {
    try {
      String suggestedTagName =
          await tagSuggester.suggestTag(videoTitle, videoDescription);
      var existingTags = await ref.read(apiServiceProvider).fetchTagList();
      var matchingTag = existingTags.firstWhere(
        (tag) => tag['name'].toString() == suggestedTagName,
        orElse: () => null,
      );

      if (matchingTag != null) {
        await ref
            .read(apiServiceProvider)
            .addTagToVideo(videoId, matchingTag['id']);
        setState(() {
          tags.add(matchingTag);
        });
      }
    } catch (e) {
      print('Error adding matching tags: $e');
    }
  }

  void _navigateToEmptyPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreatPanelPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final videoId = ref.watch(selectedVideoIdProvider);

    if (videoId == null) {
      return const Center(child: Text('Select a video'));
    }

    return SingleChildScrollView(
        // 여기에 SingleChildScrollView를 추가합니다.
        child: FutureBuilder(
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
                              child: SelectedItemCustomList(
                                items: panels,
                                onRemove: (id) => removePanel(id),
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: SelectedItemCustomList(
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
                    Expanded(child: SearchPanelTab()),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EditCustomButton(
                            text: '추가',
                            onPressed: () async {
                              final searchQuery = ref
                                  .read(searchPanelQueryProvider.notifier)
                                  .state;

                              if (searchQuery != null &&
                                  searchQuery.isNotEmpty) {
                                final videoId =
                                    ref.watch(selectedVideoIdProvider);

                                if (videoId != null) {
                                  final panelListAsyncValue =
                                      ref.watch(panelListProvider);

                                  await panelListAsyncValue
                                      .whenData((panelList) async {
                                    final matchingPanel = panelList.firstWhere(
                                      (panel) =>
                                          panel['name'].toString() ==
                                          searchQuery,
                                      orElse: () => null,
                                    );

                                    if (matchingPanel != null) {
                                      await addPanel(matchingPanel['id'],
                                          matchingPanel['name']);
                                    } else {}
                                  });
                                }
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: TextButton(
                              onPressed: () => _navigateToEmptyPage(context),
                              child: Text(
                                '생성',
                                style: TextStyle(color: Colors.white), // 흰색 글씨
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black, // 검은색 배경
                              ),
                            ),
                          )
                        ]),
                    Expanded(
                        child: SearchTagTab(
                      onDelete: (id) => deleteTag(id),
                    )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                          child: EditCustomButton(
                            text: '직접 추가',
                            onPressed: () async {
                              // 추가 눌렀을 때 태그 자동 생성하고 추가하기
                              // final videoTitle = videoData['title'];
                              // final videoId = ref.watch(selectedVideoIdProvider);
                              // if (videoTitle != null && videoId != null) {
                              //   await addCreatedTagsToVideo(
                              //       videoTitle, videoId, tagGenerator);
                              // }

                              // 추가 눌렀을 때 작성한 태그 추가하기
                              final searchQuery = ref
                                  .read(searchTagQueryProvider.notifier)
                                  .state;

                              if (searchQuery != null &&
                                  searchQuery.isNotEmpty) {
                                final videoId =
                                    ref.watch(selectedVideoIdProvider);

                                if (videoId != null) {
                                  await addTag(searchQuery);
                                }
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: TextButton(
                            onPressed: () async {
                              final videoTitle = videoData['title'];
                              final videoDescription = videoData['description'];
                              final videoId =
                                  ref.watch(selectedVideoIdProvider);
                              if (videoTitle != null && videoId != null) {
                                await addCreatedTagsToVideo(videoTitle, videoId,
                                    tagGenerator, videoDescription);
                              }
                            },
                            child: Text(
                              'AI 생성 태그 추가',
                              style: TextStyle(color: Colors.white), // 흰색 글씨
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black, // 검은색 배경
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 8, 0),
                          child: TextButton(
                            onPressed: () async {
                              final videoTitle = videoData['title'];
                              final videoDescription = videoData['description'];
                              final videoId =
                                  ref.watch(selectedVideoIdProvider);
                              if (videoTitle != null && videoId != null) {
                                await addMatchingTagsToVideo(
                                    videoTitle, videoId, videoDescription);
                              }
                            },
                            child: Text(
                              '기존 태그 중 AI 추가',
                              style: TextStyle(color: Colors.white), // 흰색 글씨
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black, // 검은색 배경
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  videoData['description'],
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
