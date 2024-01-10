import 'package:admin/videodetailsview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/riverpod.dart';

class VideoListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoList = ref.watch(videoListProvider);

    return ListView.builder(
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(videoList[index]['title']),
          onTap: () {

          },
        );
      },
    );
  }
}