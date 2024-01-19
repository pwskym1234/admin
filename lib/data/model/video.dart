import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:admin/data/enum/video_type.dart';
import 'video_panel.dart';
import 'video_tag.dart';

part 'video.freezed.dart';
part 'video.g.dart';

extension VideoX on Video {
  String get youtube_link_id {
    return Uri.parse(youtube_link).queryParameters['v']!;
  }

  VideoType get videoType {
    switch (type) {
      case "REPLAY":
        return VideoType.replay;
      case "LIVE":
        return VideoType.live;
      default:
        return VideoType.video;
    }
  }

  void pushPlayerPage(BuildContext context) =>
      context.push('/player/$youtube_link_id?vid=$id');
}

@freezed
class Video with _$Video {
  factory Video({
    required int id,
    required String title,
    required String description,
    required String thumbnail_url,
    required String youtube_link,
    required int view_count,
    required String type,
    @Default([]) List<VideoPanel> panels,
    @Default([]) List<VideoTag> tags,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
