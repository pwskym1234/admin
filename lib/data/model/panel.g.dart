// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PanelImpl _$$PanelImplFromJson(Map<String, dynamic> json) => _$PanelImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      subscription_count: json['subscription_count'] as int,
      thumbnail_url: json['thumbnail_url'] as String,
    );

Map<String, dynamic> _$$PanelImplToJson(_$PanelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subscription_count': instance.subscription_count,
      'thumbnail_url': instance.thumbnail_url,
    };
