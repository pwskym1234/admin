import 'package:flutter/material.dart';

class UpdateTagButton extends StatelessWidget {
  final Function(String?) onUpdateTag;
  final String? searchTagToUpdate;

  const UpdateTagButton(
      {Key? key, required this.onUpdateTag, required this.searchTagToUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onUpdateTag(searchTagToUpdate),
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
        '태그 업데이트',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
