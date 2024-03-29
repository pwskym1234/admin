import 'package:flutter/material.dart';

class CreatePanelButton extends StatelessWidget {
  final VoidCallback onCreatePanel;

  const CreatePanelButton({super.key, required this.onCreatePanel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onCreatePanel,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.black, // 글씨색 변경
        minimumSize: const Size(160, 50), // 버튼의 최소 크기 설정
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // 버튼 내부 패딩 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 둥근 모서리 반경 설정
        ),
      ),
      child: const Text(
        '패널 생성',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
