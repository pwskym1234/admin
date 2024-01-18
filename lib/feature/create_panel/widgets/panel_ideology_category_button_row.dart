import 'package:flutter/material.dart';

class PoliticalTypeButtonRow extends StatelessWidget {
  final int? selectedPoliticalTypeId;
  final Function(int) onSelectPoliticalType;

  PoliticalTypeButtonRow({
    required this.selectedPoliticalTypeId,
    required this.onSelectPoliticalType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => onSelectPoliticalType(1),
          child: Text('진보', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) =>
                  selectedPoliticalTypeId == 1 ? Colors.blue : Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => onSelectPoliticalType(2),
          child: Text('중도', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) =>
                  selectedPoliticalTypeId == 2 ? Colors.purple : Colors.grey,
            ),
          ),
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => onSelectPoliticalType(3),
          child: Text('보수', style: TextStyle(color: Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) =>
                  selectedPoliticalTypeId == 3 ? Colors.red : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
