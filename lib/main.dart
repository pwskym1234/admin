import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/videolistview.dart'; 

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Row( // Row 위젯 사용
        children: [
          Spacer(), // 왼쪽 공간을 만들어주는 위젯
          Expanded( // 오른쪽에 VideoListView를 배치
            flex: 1, // 화면 공간 비율 조정 (필요에 따라 조절 가능)
            child: VideoListView(),
          ),
        ],
      ),
    );
  }
}


