import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/feature/create_panel/logic/create_panel_controller.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:admin/feature/create_panel/widgets/panel_ideology_category_button_row.dart';
import 'package:admin/feature/create_panel/widgets/create_panel_button.dart';
import 'package:admin/feature/create_panel/widgets/panel_name_textfield.dart';
import 'package:admin/feature/create_panel/widgets/panel_thumbnail_button.dart';
import 'dart:html' as html;
import 'dart:convert';
import 'package:admin/data/service/server_api_service.dart';

class CreatPanelPage extends ConsumerStatefulWidget {
  @override
  _CreatePanelPageState createState() => _CreatePanelPageState();
}

class _CreatePanelPageState extends ConsumerState<CreatPanelPage> {
  List<int>? imageByte;
  String? imageName;
  final TextEditingController panelNameController = TextEditingController();
  // final TextEditingController categoryIdController = TextEditingController();

  Future<void> selectThumbnail() async {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.click();

    input.onChange.listen((e) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        final html.File file = files.first;

        final reader = html.FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen((event) {
          setState(() {
            imageByte = base64.decode(reader.result.toString().split(",").last);
            imageName = file.name;
          });
          print("File selected successfully.");
        });
      }
    });
  }

  // Future<void> selectThumbnail() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       withData: true,
  //     );

  //     if (result != null && result.files.isNotEmpty) {
  //       setState(() {
  //         PlatformFile platformFile = result.files.first;
  //         imageByte = platformFile.bytes!;
  //         imageName = platformFile.name;
  //       });
  //       print("File selected successfully.");
  //     }
  //   } catch (e) {
  //     print("Error during file selection: $e");
  //   }
  // }

  void resetPage() {
    setState(() {
      panelNameController.clear();
      // categoryIdController.clear();
      imageByte = null;
      imageName = null;
      ref.read(selectedPoliticalTypeIdProvider.notifier).state = null;
    });
  }

  void createPanel() async {
    final String panelName = panelNameController.text;
    // final int categoryId = int.tryParse(categoryIdController.text) ?? 0;
    int? politicalTypeId = ref.watch(selectedPoliticalTypeIdProvider);

    if (politicalTypeId != null) {
      await ServerApiService().createPanel(
          panelName: panelName,
          politicalTypeId: politicalTypeId,
          imageByte: imageByte,
          fileName: imageName);
      print(politicalTypeId);

      resetPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedPoliticalTypeId = ref.watch(selectedPoliticalTypeIdProvider);

    void selectCategory(int politicalTypeId) {
      if (selectedPoliticalTypeId == politicalTypeId) {
        ref.read(selectedPoliticalTypeIdProvider.notifier).state = null;
        print(ref.watch(selectedPoliticalTypeIdProvider));
        print(politicalTypeId);
      } else {
        ref.read(selectedPoliticalTypeIdProvider.notifier).state =
            politicalTypeId;
        print(ref.watch(selectedPoliticalTypeIdProvider));
        print(politicalTypeId);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('패널 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PanelNameTextField(controller: panelNameController),
                SizedBox(height: 24),
                PanelThumbnailButton(
                  imageName: imageName,
                  onSelectThumbnail: selectThumbnail,
                  onCancelThumbnail: () {
                    setState(() {
                      imageByte = null;
                      imageName = null;
                    });
                  },
                ),
                SizedBox(height: 24),
                PoliticalTypeButtonRow(
                  selectedPoliticalTypeId: selectedPoliticalTypeId,
                  onSelectPoliticalType: selectCategory,
                ),
                SizedBox(height: 100),
                CreatePanelButton(onCreatePanel: createPanel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class _EmptyPageState extends ConsumerState<EmptyPage> {
//   final TextEditingController panelNameController = TextEditingController();
//   final TextEditingController categoryIdController = TextEditingController();
//   List<int>? imageByte;
//   String? imageName;
//   @override
//   Widget build(BuildContext context) {
//     final selectedCategoryId = ref.watch(selectedCategoryIdProvider);

//     void selectCategory(int categoryId) {
//       if (selectedCategoryId == categoryId) {
//         ref.read(selectedCategoryIdProvider.notifier).state = null;
//       } else {
//         ref.read(selectedCategoryIdProvider.notifier).state = categoryId;
//       }
//     }

//     Future<void> selectThumbnail() async {
//       try {
//         FilePickerResult? result = await FilePicker.platform.pickFiles(
//           type: FileType.image,
//           withData: true,
//         );

//         if (result != null && result.files.isNotEmpty) {
//           setState(() {
//             PlatformFile platformFile = result.files.first;
//             imageByte = platformFile.bytes!;
//             imageName = platformFile.name;
//           });
//           print("File selected successfully.");
//         }
//       } catch (e) {
//         print("Error during file selection: $e");
//       }
//     }

//     void resetPage() {
//       setState(() {
//         panelNameController.clear();
//         categoryIdController.clear();
//         imageByte = null;
//         imageName = null;
//         ref.read(selectedCategoryIdProvider.notifier).state = null;
//       });
//     }

//     void createPanel() async {
//       final String panelName = panelNameController.text;
//       final int categoryId = int.tryParse(categoryIdController.text) ?? 0;

//       await ApiService()
//           .createPanel(panelName, categoryId, imageByte, imageName);

//       resetPage();
//     }

//     Widget buildThumbnailButton() {
//       return Stack(
//         alignment: Alignment.topRight,
//         children: [
//           OutlinedButton(
//             onPressed: selectThumbnail,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.photo),
//                 Text(
//                   imageName != null ? '사진 첨부됨' : '사진 첨부',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             style: OutlinedButton.styleFrom(
//               primary: imageName != null ? Colors.black : Colors.grey,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               minimumSize: Size(160, 200),
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             ),
//           ),
//           if (imageName != null) // 이미지가 선택된 경우에만 X 버튼을 표시
//             IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 setState(() {
//                   imageByte = null;
//                   imageName = null;
//                 });
//               },
//             ),
//         ],
//       );
//     }

// //       if (thumbnailPreview != null) {
// //     // createPanel API 호출 로직
// //     // thumbnailPreview를 사용하여 API 호출
// //     await ApiService().createPanel(panelName, thumbnailPreview!, categoryId);
// //   } else {
// //     print('Thumbnail image is not selected');
// //   }
// // }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('패널 추가'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Container(
//             width: MediaQuery.of(context).size.width * 0.5,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 TextField(
//                   controller: panelNameController,
//                   decoration: InputDecoration(
//                     labelText: '패널 이름',
//                     hintText: '패널 이름을 입력하세요',
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 DottedBorder(
//                   borderType: BorderType.RRect,
//                   radius: Radius.circular(12),
//                   padding: EdgeInsets.all(6),
//                   dashPattern: [8, 4],
//                   color: Colors.grey,
//                   child: buildThumbnailButton(),
//                 ),
//                 SizedBox(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () => selectCategory(1),
//                           child:
//                               Text('진보', style: TextStyle(color: Colors.white)),
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.resolveWith<Color>(
//                               (states) => selectedCategoryId == 1
//                                   ? Colors.blue
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                         ElevatedButton(
//                           onPressed: () => selectCategory(2),
//                           child:
//                               Text('중도', style: TextStyle(color: Colors.white)),
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.resolveWith<Color>(
//                               (states) => selectedCategoryId == 2
//                                   ? Colors.purple
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                         ElevatedButton(
//                           onPressed: () => selectCategory(3),
//                           child:
//                               Text('보수', style: TextStyle(color: Colors.white)),
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.resolveWith<Color>(
//                               (states) => selectedCategoryId == 3
//                                   ? Colors.red
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 100),
//                 ElevatedButton(
//                   onPressed: createPanel,
//                   child: Text(
//                     '패널 생성',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.black, // 배경색 변경
//                     onPrimary: Colors.white, // 글씨색 변경
//                     minimumSize: Size(160, 50), // 버튼의 최소 크기 설정
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 10), // 버튼 내부 패딩 설정
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8), // 둥근 모서리 반경 설정
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








