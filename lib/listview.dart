import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List<dynamic> items;
  final Function(dynamic) itemBuilder;

  CustomListView({required this.items, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(items[index]);
      },
    );
  }
}
