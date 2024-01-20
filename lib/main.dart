import 'package:admin/feature/home/widgets/untagged_video_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/widgets/live_video_list.dart';
import 'package:admin/feature/home/selected_video_details.dart';
import 'package:admin/feature/home/logic/home_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
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
    // selectedVideoIdProvider에서 현재 선택된 videoId를 가져옵니다.
    final selectedVideoId = ref.watch(selectedVideoIdProvider);

    return DefaultTabController(
      length: 2, // 탭의 개수
      child: Scaffold(
        body: Row(
          children: [
            if (selectedVideoId != null) SizedBox(width: 20),

            Expanded(
              child: SelectedVideoDetails(videoId: selectedVideoId ?? 0),
            ),

            VerticalDivider(width: 1), // 섹션 구분선

            // TabBar를 포함하는 Container
            Container(
              width: 300, // 고정된 너비 지정
              child: Column(
                children: [
                  // TabBar 정의
                  TabBar(
                    tabs: [
                      Tab(text: '라이브 영상 리스트'),
                      Tab(text: '태그가 필요한 영상 리스트'),
                    ],
                  ),
                  Expanded(
                    // TabBarView 정의
                    child: TabBarView(
                      children: [
                        LiveVideoList(), // 첫 번째 탭의 내용
                        UntaggedVideoList(), // 두 번째 탭의 내용 (빈 공간)
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
