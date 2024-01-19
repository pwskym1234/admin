import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';

part 'panel.freezed.dart';
part 'panel.g.dart';

extension PanelX on Panel {
  void pushPanelDetailPage(BuildContext context) =>
      context.push('/panel_detail/$id?pName=$name');
}

@freezed
class Panel with _$Panel {
  factory Panel({
    required int id,
    required String name,
    required int subscription_count,
    required String thumbnail_url,
  }) = _Panel;

  factory Panel.fromJson(Map<String, dynamic> json) => _$PanelFromJson(json);
}
