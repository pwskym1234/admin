import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/home/logic/home_controller.dart';
import 'package:admin/data/apiservice.dart';

class SearchUntaggedVideoTab extends ConsumerWidget {
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
            decoration: InputDecoration(
              labelText: '비디오 제목 검색',
              hintText: '비디오 제목를 입력하세요',
            ),
          ),
        ],
      ),
    );
  }
}
