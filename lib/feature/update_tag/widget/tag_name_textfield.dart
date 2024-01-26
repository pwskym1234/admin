import 'package:flutter/material.dart';

class TagNameTextField extends StatelessWidget {
  final TextEditingController controller;

  const TagNameTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: '태그 이름',
        hintText: '태그 이름을 입력하세요',
      ),
    );
  }
}
