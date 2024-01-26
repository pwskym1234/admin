import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/update_tag/logic/update_tag_controller.dart';

class TagToUpdateList extends ConsumerWidget {
  const TagToUpdateList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagListNotifier = ref.read(tagListToUpdateProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tagListNotifier.getTags();
    });
    final tagToUpdateList = ref.watch(tagListToUpdateProvider);

    tagToUpdateList.sort((a, b) => a['status'].compareTo(b['status']));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            '태그 리스트',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: tagToUpdateList.length,
            itemBuilder: (context, index) {
              final item = tagToUpdateList[index];
              Color circleColor;

              if (item['status'] == 1) {
                circleColor = Colors.red;
              } else if (item['status'] == 2) {
                circleColor = Color.fromARGB(255, 131, 0, 0);
              } else {
                circleColor = Color.fromARGB(255, 0, 0, 0);
              }

              return ListTile(
                title: Text(item['name']),
                trailing: CircleAvatar(
                  backgroundColor: circleColor,
                  radius: 7, // 원하는 크기로 조절하세요.
                ),
                onTap: () {
                  ref.read(selectedTagIdProvider.notifier).state = item['id'];

                  // 아이템 탭에 대한 액션을 여기에 추가하세요.
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
