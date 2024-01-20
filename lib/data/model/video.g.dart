// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      thumbnail_url: json['thumbnail_url'] as String,
      description: json['description'] as String?,
      youtube_link: json['youtube_link'] as String,
      view_count: json['view_count'] as int,
      type: json['type'] as String,
      panels: (json['panels'] as List<dynamic>?)
              ?.map((e) => VideoPanel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => VideoTag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail_url': instance.thumbnail_url,
      'description': instance.description,
      'youtube_link': instance.youtube_link,
      'view_count': instance.view_count,
      'type': instance.type,
      'panels': instance.panels,
      'tags': instance.tags,
    };
