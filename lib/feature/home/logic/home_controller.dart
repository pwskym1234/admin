
// import 'package:flutter/material.dart';
// import 'package:admin/feature/home/logic/home_provider.dart';


// import 'package:admin/feature/create_panel/creat_panel_page.dart';
// import 'package:admin/feature/home/logic/openai.dart';
// import 'package:admin/data/service/server_api_service.dart';



// class HomeController {
//   final ServerApiService apiService;
//   final OpenAiTagGenerator tagGenerator;
//   final OpenAiTagSuggester tagSuggester;
//   List<dynamic> panels = [];
//   List<dynamic> tags = [];

//   HomeController(this.apiService, this.tagGenerator, this.tagSuggester);
// Future<dynamic> fetchVideoDetails(int videoId) async {
//     var videoDetails = await ServerApiService.fetchVideoDetails(videoId: videoId);

//     panels = videoDetails.panels;

//     tags = videoDetails.tags;

//     return videoDetails;
//   }

//   Future<void> addPanel(int panelId, String panelName) async {
//     await ServerApiService
//         .addPanelToVideo(videoId: videoId, panelId);
//     setState(() {
//       var newPanel = {
//         'id': panelId,
//         'name': panelName,
//       };
//       panels.add(newPanel);
//     });
//   }

//   Future<void> removePanel(int panelId) async {
//     await ref
//         .read(serverApiServiceProvider)
//         .removePanelFromVideo(widget.videoId, panelId);
//     setState(() {
//       panels.removeWhere((panel) => panel['id'] == panelId);
//     });
//   }

//   Future<void> addTag(String tagName) async {
//     try {
//       final tagListAsyncValue = ref.watch(tagListProvider);

//       bool tagExists = false;
//       await tagListAsyncValue.whenData((tagList) {
//         tagExists = tagList.any((tag) => tag['name'] == tagName);
//       });

//       int tagId;
//       if (!tagExists) {
//         var newTag =
//             await ref.read(serverApiServiceProvider).createTag(tagName);
//         tagId = newTag.id;
//       } else {
//         tagId = tagListAsyncValue.value!.firstWhere(
//           (tag) => tag['name'] == tagName,
//           orElse: () => throw Exception('Tag not found'),
//         )['id'];
//       }

//       await ref
//           .read(serverApiServiceProvider)
//           .addTagToVideo(widget.videoId, tagId);
//       setState(() {
//         tags.add({
//           'id': tagId,
//           'name': tagName,
//         });
//       });
//     } catch (e) {
//       print('Error adding tag: $e');
//     }
//   }

//   Future<void> addCreatedTagsToVideo(String videoTitle, int videoId,
//       OpenAiTagGenerator tagGenerator, String videoDescription) async {
//     Stopwatch stopwatch = Stopwatch()..start();
//     List<String> createdTags =
//         await tagGenerator.generateTags(videoTitle, videoDescription);

//     for (var tag in createdTags) {
//       try {
//         var createdTag =
//             await ref.read(serverApiServiceProvider).createTag(tag);
//         int createdTagId = createdTag['id'];
//         String createdTagName = createdTag['name'];

//         await ref
//             .read(serverApiServiceProvider)
//             .addTagToVideo(videoId, createdTagId);

//         setState(() {
//           tags.add({
//             'id': createdTagId,
//             'name': createdTagName,
//           });
//         });
//       } catch (e) {
//         print('Error adding tag "$tag": $e');
//       }
//     }
//     stopwatch.stop();
//     print('Time taken to add tags: ${stopwatch.elapsed.inMilliseconds} ms');
//   }

//   Future<void> removeTag(int tagId) async {
//     await ref
//         .read(serverApiServiceProvider)
//         .removeTagFromVideo(widget.videoId, tagId);
//     setState(() {
//       tags.removeWhere((tag) => tag['id'] == tagId);
//     });
//   }

//   Future<void> deleteTag(int tagId) async {
//     await ref.read(serverApiServiceProvider).deleteTag(tagId);
//   }

//   Future<void> addMatchingTagsToVideo(
//       String videoTitle, int videoId, String videoDescription) async {
//     try {
//       String suggestedTagName =
//           await tagSuggester.suggestTag(videoTitle, videoDescription);
//       var existingTags =
//           await ref.read(serverApiServiceProvider).fetchTagList();
//       var matchingTag = existingTags.firstWhere(
//         (tag) => tag.name == suggestedTagName,
//       );

//       await ref
//           .read(serverApiServiceProvider)
//           .addTagToVideo(videoId, matchingTag.id);
//       setState(() {
//         tags.add(matchingTag);
//       });
//     } catch (e) {
//       print('Error adding matching tags: $e');
//     }
//   }

//   void _navigateToEmptyPage(BuildContext context) {
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (context) => CreatPanelPage()),
//     );
//   }
// }