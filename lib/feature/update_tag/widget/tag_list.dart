import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/update_tag/logic/update_tag_controller.dart';
import 'package:admin/data/api/apiservice.dart';

class TagToUpdateList extends ConsumerWidget {
  final Function(int id) onDelete;
  const TagToUpdateList({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagListNotifier = ref.read(tagListToUpdateProvider.notifier);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   tagListNotifier.getTagsToUpdate();
    // });

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
                circleColor = const Color.fromARGB(255, 131, 0, 0);
              } else {
                circleColor = const Color.fromARGB(255, 0, 0, 0);
              }

              return ListTile(
                title: Text(item['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: circleColor,
                      radius: 7, // 원하는 크기로 조절하세요.
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () async {
                          try {
                            await onDelete(item['id']);
                            tagListNotifier.getTagsToUpdate();
                            // ignore: unused_result
                          } catch (e) {
                            debugPrint('Error deleting tag: $e');
                          }
                        }),
                  ],
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
