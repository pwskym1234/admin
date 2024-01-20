import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_panel.freezed.dart';
part 'video_panel.g.dart';

@freezed
class VideoPanel with _$VideoPanel {
  factory VideoPanel({
    required int id,
    required String name,
  }) = _VideoPanel;

  factory VideoPanel.fromJson(Map<String, dynamic> json) =>
      _$VideoPanelFromJson(json);
}
