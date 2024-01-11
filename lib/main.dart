import 'package:admin/searchtab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/videolistview.dart'; 
import 'package:admin/videodetailsview.dart';
import 'package:admin/riverpod.dart';

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
      home: const MyHomePage(title: '어드민 웹'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // selectedVideoIdProvider에서 현재 선택된 videoId를 가져옵니다.
    final selectedVideoId = ref.watch(selectedVideoIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Row( // Row 위젯 사용
        children: [
          if (selectedVideoId != null)
          SizedBox(width: 20,), 
            

             VideoDetailsView(videoId: selectedVideoId??0),

        
            Spacer(),
          VerticalDivider(width: 1), // 섹션 구분선
          Container(
            width: 300, // 고정된 너비 지정
            child: VideoListView(),
          ),
        ],
      ),
    );
  }
}
