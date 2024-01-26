import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';

class SearchUntaggedVideoTab extends ConsumerWidget {
  const SearchUntaggedVideoTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (query) {
              ref.read(searchVideoQueryProvider.notifier).state = query;
            },
            decoration: const InputDecoration(
              labelText: '비디오 제목 검색',
              hintText: '비디오 제목를 입력하세요',
            ),
          ),
        ],
      ),
    );
  }
}
