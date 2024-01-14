import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}


// class SearchTabWithButton extends StatelessWidget {
//   final Widget searchTab;
//   final StateProvider<String?> searchQueryProvider;
//   final FutureProvider<List<dynamic>> listProvider;
//   final Future<void> Function(int id, String name) addItem;

//   const SearchTabWithButton({
//     Key? key,
//     required this.searchTab,
//     required this.searchQueryProvider,
//     required this.listProvider,
//     required this.addItem,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, _) {
//         return Row(
//           children: [
//             Expanded(child: searchTab),
//             Padding(
//               padding: const EdgeInsets.only(top: 35),
//               child: TextButton(
//                 onPressed: () async {
//                   final searchQuery =
//                       ref.read(searchQueryProvider.notifier).state;
//                   final listAsyncValue = ref.watch(listProvider);

//                   await listAsyncValue.whenData((list) async {
//                     final matchingItem = list.firstWhere(
//                       (item) => item['name'].toString() == searchQuery,
//                       orElse: () => null,
//                     );
//                     final videoId = ref.watch(selectedVideoIdProvider);

//                     if (matchingItem != null && videoId != null) {
//                       await addItem(matchingItem['id'], matchingItem['name']);
//                     }
//                   });
//                 },
//                 child: const Text(
//                   '추가',
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 style: TextButton.styleFrom(
//                   backgroundColor: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
