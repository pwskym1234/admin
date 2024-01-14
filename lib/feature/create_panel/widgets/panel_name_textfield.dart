import 'package:flutter/material.dart';

class PanelNameTextField extends StatelessWidget {
  final TextEditingController controller;

  PanelNameTextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '패널 이름',
        hintText: '패널 이름을 입력하세요',
      ),
    );
  }
}
