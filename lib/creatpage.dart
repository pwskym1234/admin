import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/riverpod.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:admin/dio.dart';
import 'package:admin/riverpod.dart';

class EmptyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController panelNameController = TextEditingController();

    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);
    File? thumbnailFile;
    final TextEditingController categoryIdController = TextEditingController();

    void selectCategory(int categoryId) {
      if (selectedCategoryId == categoryId) {
        ref.read(selectedCategoryIdProvider.notifier).state = null;
      } else {
        ref.read(selectedCategoryIdProvider.notifier).state = categoryId;
      }
    }

    Future<void> selectThumbnail() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        thumbnailFile = File(result.files.single.path!);
      }
    }

    void createPanel() async {
      final String panelName = panelNameController.text;
      final int categoryId = int.tryParse(categoryIdController.text) ?? 0;

      if (thumbnailFile != null) {
        // createPanel API 호출 로직
        await ApiService().createPanel(panelName, thumbnailFile!, categoryId);
      } else {
        print('Thumbnail file is not selected');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: panelNameController,
                  decoration: InputDecoration(
                    labelText: '패널 이름',
                    hintText: '패널 이름을 입력하세요',
                  ),
                ),
                SizedBox(height: 24),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(6),
                  dashPattern: [8, 4],
                  color: Colors.grey,
                  child: OutlinedButton(
                    onPressed: selectThumbnail,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.photo),
                        Text('사진 첨부'),
                      ],
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(160, 200),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => selectCategory(1),
                          child:
                              Text('진보', style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) => selectedCategoryId == 1
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () => selectCategory(2),
                          child:
                              Text('중도', style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) => selectedCategoryId == 2
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () => selectCategory(3),
                          child:
                              Text('보수', style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) => selectedCategoryId == 3
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 100),
                ElevatedButton(
                  onPressed: createPanel,
                  child: Text(
                    '패널 생성',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // 배경색 변경
                    onPrimary: Colors.white, // 글씨색 변경
                    minimumSize: Size(160, 50), // 버튼의 최소 크기 설정
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // 버튼 내부 패딩 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // 둥근 모서리 반경 설정
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



  // Future<void> addPanel(String panelName) async {
  //   try {
  //     final panelListAsyncValue = ref.watch(panelListProvider);

  //     bool panelExists = false;
  //     await panelListAsyncValue.whenData((panelList) {
  //       panelExists = panelList.any((panel) => panel['name'] == panelName);
  //     });

  //     int panelId;
  //     if (!panelExists) {
  //       var newPanel =
  //           await ref.read(apiServiceProvider).createPanel(panelName,);
  //       panelId = newPanel['id'];
  //     } else {
  //       panelId = panelListAsyncValue.value!.firstWhere(
  //         (panel) => panel['name'] == panelName,
  //         orElse: () => throw Exception('Panel not found'),
  //       )['id'];
  //     }

  //     await ref
  //         .read(apiServiceProvider)
  //         .addPanelToVideo(widget.videoId, panelId);
  //     setState(() {
  //       tags.add({
  //         'id': panelId,
  //         'name': panelName,
  //       });
  //     });
  //   } catch (e) {
  //     print('Error adding tag: $e');
  //   }
  // }
