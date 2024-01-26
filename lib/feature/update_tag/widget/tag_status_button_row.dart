import 'package:flutter/material.dart';

class TagStatusButtonRow extends StatelessWidget {
  final int? selectedTagStatusId;
  final Function(int) onSelectTagStatus;

  const TagStatusButtonRow({
    super.key,
    required this.selectedTagStatusId,
    required this.onSelectTagStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => onSelectTagStatus(1),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => selectedTagStatusId == 1 ? Colors.red : Colors.grey,
            ),
          ),
          child: const Text('핫이슈', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => onSelectTagStatus(2),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => selectedTagStatusId == 2
                  ? Color.fromARGB(255, 103, 0, 0)
                  : Colors.grey,
            ),
          ),
          child: const Text('그래도 이슈', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => onSelectTagStatus(3),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => selectedTagStatusId == 3
                  ? Color.fromARGB(255, 0, 0, 0)
                  : Colors.grey,
            ),
          ),
          child: const Text('퇴물', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
