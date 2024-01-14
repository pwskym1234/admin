import 'package:flutter/material.dart';

class PanelThumbnailButton extends StatelessWidget {
  final String? imageName;
  final VoidCallback onSelectThumbnail;
  final VoidCallback onCancelThumbnail;

  PanelThumbnailButton({
    required this.imageName,
    required this.onSelectThumbnail,
    required this.onCancelThumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        OutlinedButton(
          onPressed: onSelectThumbnail,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.photo),
              Text(
                imageName != null ? '사진 첨부됨' : '사진 첨부',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          style: OutlinedButton.styleFrom(
            primary: imageName != null ? Colors.black : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: Size(160, 200),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        if (imageName != null) // 이미지가 선택된 경우에만 X 버튼을 표시
          IconButton(
            icon: Icon(Icons.close),
            onPressed: onCancelThumbnail,
          ),
      ],
    );
  }
}
