// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Video _$VideoFromJson(Map<String, dynamic> json) {
  return _Video.fromJson(json);
}

/// @nodoc
mixin _$Video {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get thumbnail_url => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get youtube_link => throw _privateConstructorUsedError;
  int get view_count => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  List<VideoPanel> get panels => throw _privateConstructorUsedError;
  List<VideoTag> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoCopyWith<Video> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoCopyWith<$Res> {
  factory $VideoCopyWith(Video value, $Res Function(Video) then) =
      _$VideoCopyWithImpl<$Res, Video>;
  @useResult
  $Res call(
      {int id,
      String title,
      String thumbnail_url,
      String? description,
      String youtube_link,
      int view_count,
      String type,
      List<VideoPanel> panels,
      List<VideoTag> tags});
}

/// @nodoc
class _$VideoCopyWithImpl<$Res, $Val extends Video>
    implements $VideoCopyWith<$Res> {
  _$VideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail_url = null,
    Object? description = freezed,
    Object? youtube_link = null,
    Object? view_count = null,
    Object? type = null,
    Object? panels = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail_url: null == thumbnail_url
          ? _value.thumbnail_url
          : thumbnail_url // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube_link: null == youtube_link
          ? _value.youtube_link
          : youtube_link // ignore: cast_nullable_to_non_nullable
              as String,
      view_count: null == view_count
          ? _value.view_count
          : view_count // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      panels: null == panels
          ? _value.panels
          : panels // ignore: cast_nullable_to_non_nullable
              as List<VideoPanel>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<VideoTag>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoImplCopyWith<$Res> implements $VideoCopyWith<$Res> {
  factory _$$VideoImplCopyWith(
          _$VideoImpl value, $Res Function(_$VideoImpl) then) =
      __$$VideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String thumbnail_url,
      String? description,
      String youtube_link,
      int view_count,
      String type,
      List<VideoPanel> panels,
      List<VideoTag> tags});
}

/// @nodoc
class __$$VideoImplCopyWithImpl<$Res>
    extends _$VideoCopyWithImpl<$Res, _$VideoImpl>
    implements _$$VideoImplCopyWith<$Res> {
  __$$VideoImplCopyWithImpl(
      _$VideoImpl _value, $Res Function(_$VideoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? thumbnail_url = null,
    Object? description = freezed,
    Object? youtube_link = null,
    Object? view_count = null,
    Object? type = null,
    Object? panels = null,
    Object? tags = null,
  }) {
    return _then(_$VideoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnail_url: null == thumbnail_url
          ? _value.thumbnail_url
          : thumbnail_url // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      youtube_link: null == youtube_link
          ? _value.youtube_link
          : youtube_link // ignore: cast_nullable_to_non_nullable
              as String,
      view_count: null == view_count
          ? _value.view_count
          : view_count // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      panels: null == panels
          ? _value._panels
          : panels // ignore: cast_nullable_to_non_nullable
              as List<VideoPanel>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<VideoTag>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoImpl implements _Video {
  _$VideoImpl(
      {required this.id,
      required this.title,
      required this.thumbnail_url,
      this.description,
      required this.youtube_link,
      required this.view_count,
      required this.type,
      final List<VideoPanel> panels = const [],
      final List<VideoTag> tags = const []})
      : _panels = panels,
        _tags = tags;

  factory _$VideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String thumbnail_url;
  @override
  final String? description;
  @override
  final String youtube_link;
  @override
  final int view_count;
  @override
  final String type;
  final List<VideoPanel> _panels;
  @override
  @JsonKey()
  List<VideoPanel> get panels {
    if (_panels is EqualUnmodifiableListView) return _panels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_panels);
  }

  final List<VideoTag> _tags;
  @override
  @JsonKey()
  List<VideoTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'Video(id: $id, title: $title, thumbnail_url: $thumbnail_url, description: $description, youtube_link: $youtube_link, view_count: $view_count, type: $type, panels: $panels, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.thumbnail_url, thumbnail_url) ||
                other.thumbnail_url == thumbnail_url) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.youtube_link, youtube_link) ||
                other.youtube_link == youtube_link) &&
            (identical(other.view_count, view_count) ||
                other.view_count == view_count) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._panels, _panels) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      thumbnail_url,
      description,
      youtube_link,
      view_count,
      type,
      const DeepCollectionEquality().hash(_panels),
      const DeepCollectionEquality().hash(_tags));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      __$$VideoImplCopyWithImpl<_$VideoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoImplToJson(
      this,
    );
  }
}

abstract class _Video implements Video {
  factory _Video(
      {required final int id,
      required final String title,
      required final String thumbnail_url,
      final String? description,
      required final String youtube_link,
      required final int view_count,
      required final String type,
      final List<VideoPanel> panels,
      final List<VideoTag> tags}) = _$VideoImpl;

  factory _Video.fromJson(Map<String, dynamic> json) = _$VideoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get thumbnail_url;
  @override
  String? get description;
  @override
  String get youtube_link;
  @override
  int get view_count;
  @override
  String get type;
  @override
  List<VideoPanel> get panels;
  @override
  List<VideoTag> get tags;
  @override
  @JsonKey(ignore: true)
  _$$VideoImplCopyWith<_$VideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
