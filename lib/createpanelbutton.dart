import 'package:flutter/material.dart';

class CreatePanelButton extends StatelessWidget {
  final VoidCallback onCreatePanel;

  CreatePanelButton({required this.onCreatePanel});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onCreatePanel,
      child: Text(
        '패널 생성',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.black, // 배경색 변경
        onPrimary: Colors.white, // 글씨색 변경
        minimumSize: Size(160, 50), // 버튼의 최소 크기 설정
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 버튼 내부 패딩 설정
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 둥근 모서리 반경 설정
        ),
      ),
    );
  }
}
