import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

part 'video_tag.freezed.dart';
part 'video_tag.g.dart';

extension VideoTagX on VideoTag {
  void pushTagDetailPage(BuildContext context) =>
      context.push('/tag_detail/$name?tId=$id');
}

@freezed
class VideoTag with _$VideoTag {
  factory VideoTag({
    required int id,
    required String name,
  }) = _VideoTag;

  factory VideoTag.fromJson(Map<String, dynamic> json) =>
      _$VideoTagFromJson(json);
}
