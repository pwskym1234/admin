import 'package:admin/feature/update_tag/widget/tag_list.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/update_tag/logic/update_tag_controller.dart';
import 'package:admin/data/api/apiservice.dart';
import 'widget/tag_status_button_row.dart';
import 'widget/update_tag_button.dart';

import 'widget/search_tag_to_update_tab.dart';

class UpdateTagPage extends ConsumerStatefulWidget {
  const UpdateTagPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateTagPageState createState() => _UpdateTagPageState();
}

class _UpdateTagPageState extends ConsumerState<UpdateTagPage> {
  final TextEditingController tagNameController = TextEditingController();

  void resetPage() {
    setState(() {
      tagNameController.clear();
      ref.read(selectedTagIdProvider.notifier).state = null;
      ref.read(selectedTagStatusIdProvider.notifier).state = null;
    });
  }

  // void updateTag() async {
  //   final String tagName = tagNameController.text;
  //    final tagListAsyncValue = ref.watch(searchBarTagListProvider);
  //   int? tagStatusId = ref.watch(selectedTagStatusIdProvider);
  //   int? tagId = ref.watch(selectedTagIdProvider);

  //   if (tagStatusId != null && tagId != null) {
  //     await ApiService().updateTag(tagId, tagStatusId);

  //     resetPage();
  //   }
  // }

  void updateTag(String? tagName) async {
    print('Updating tag: $tagName');
    final tagListAsyncValue = ref.watch(searchBarTagListProvider);
    int? tagStatusId = ref.watch(selectedTagStatusIdProvider);

    print('Current tagStatusId: $tagStatusId');

    bool tagExists = false;
    tagListAsyncValue.whenData((tagList) {
      tagExists = tagList.any((tag) => tag['name'] == tagName);
    });

    int tagId;

    tagId = tagListAsyncValue.value!.firstWhere(
      (tag) => tag['name'] == tagName,
      orElse: () => throw Exception('Tag not found'),
    )['id'];
    print('Found tagId: $tagId');
    if (tagStatusId != null) {
      await ApiService().updateTag(tagId, tagStatusId);

      resetPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTagStatusId = ref.watch(selectedTagStatusIdProvider);

    void selectTagStatus(int tagStatusId) {
      if (selectedTagStatusId == tagStatusId) {
        ref.read(selectedTagStatusIdProvider.notifier).state = null;
        print(ref.watch(selectedTagStatusIdProvider));
        print(tagStatusId);
      } else {
        ref.read(selectedTagStatusIdProvider.notifier).state = tagStatusId;
        print(ref.watch(selectedTagStatusIdProvider));
        print(tagStatusId);
      }
    }

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SearchTagToUpdateTab(),
                    const SizedBox(height: 24),
                    TagStatusButtonRow(
                      selectedTagStatusId: selectedTagStatusId,
                      onSelectTagStatus: selectTagStatus,
                    ),
                    const SizedBox(height: 100),
                    UpdateTagButton(
                      onUpdateTag: (searchTagToUpdate) =>
                          updateTag(searchTagToUpdate),
                      searchTagToUpdate: ref
                          .read(searchTagToUpdateQueryProvider.notifier)
                          .state,
                    ),
                    Container(),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          const SizedBox(
            width: 300,
            child: TagToUpdateList(),
          ),
        ],
      ),
    );
  }
}
