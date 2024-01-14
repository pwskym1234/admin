import 'package:flutter/material.dart';

class CategorySelection extends StatelessWidget {
  final int? selectedCategoryId;
  final Function(int) onSelectCategory;

  CategorySelection({
    required this.selectedCategoryId,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => onSelectCategory(1),
          child: Text('진보', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => selectedCategoryId == 1 ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => onSelectCategory(2),
          child: Text('중도', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => selectedCategoryId == 2 ? Colors.purple : Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => onSelectCategory(3),
          child: Text('보수', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => selectedCategoryId == 3 ? Colors.red : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
