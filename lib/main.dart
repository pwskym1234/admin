import 'package:admin/feature/home/widgets/untagged_video_list.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/widgets/live_video_list.dart';
import 'package:admin/feature/home/selected_video_details.dart';
import 'package:admin/feature/home/logic/home_controller.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedVideoId = ref.watch(selectedVideoIdProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Row(
          children: [
            if (selectedVideoId != null) const SizedBox(width: 20),
            Expanded(
              child: SelectedVideoDetails(videoId: selectedVideoId ?? 0),
            ),
            const VerticalDivider(width: 1),
            const SizedBox(
              width: 300,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: '라이브 영상 리스트'),
                      Tab(text: '태그가 필요한 영상 리스트'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        LiveVideoList(),
                        UntaggedVideoList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
