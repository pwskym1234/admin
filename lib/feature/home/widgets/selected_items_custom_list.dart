import 'package:flutter/material.dart';

class SelectedItemCustomList extends StatelessWidget {
  final List<dynamic> items;
  final Function(int id) onRemove;

  const SelectedItemCustomList({
    Key? key,
    required this.items,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item['name']),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => onRemove(item['id']),
          ),
        );
      },
    );
  }
}
