// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoTag _$VideoTagFromJson(Map<String, dynamic> json) {
  return _VideoTag.fromJson(json);
}

/// @nodoc
mixin _$VideoTag {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoTagCopyWith<VideoTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoTagCopyWith<$Res> {
  factory $VideoTagCopyWith(VideoTag value, $Res Function(VideoTag) then) =
      _$VideoTagCopyWithImpl<$Res, VideoTag>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$VideoTagCopyWithImpl<$Res, $Val extends VideoTag>
    implements $VideoTagCopyWith<$Res> {
  _$VideoTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoTagImplCopyWith<$Res>
    implements $VideoTagCopyWith<$Res> {
  factory _$$VideoTagImplCopyWith(
          _$VideoTagImpl value, $Res Function(_$VideoTagImpl) then) =
      __$$VideoTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$VideoTagImplCopyWithImpl<$Res>
    extends _$VideoTagCopyWithImpl<$Res, _$VideoTagImpl>
    implements _$$VideoTagImplCopyWith<$Res> {
  __$$VideoTagImplCopyWithImpl(
      _$VideoTagImpl _value, $Res Function(_$VideoTagImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$VideoTagImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoTagImpl implements _VideoTag {
  _$VideoTagImpl({required this.id, required this.name});

  factory _$VideoTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoTagImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'VideoTag(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoTagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoTagImplCopyWith<_$VideoTagImpl> get copyWith =>
      __$$VideoTagImplCopyWithImpl<_$VideoTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoTagImplToJson(
      this,
    );
  }
}

abstract class _VideoTag implements VideoTag {
  factory _VideoTag({required final int id, required final String name}) =
      _$VideoTagImpl;

  factory _VideoTag.fromJson(Map<String, dynamic> json) =
      _$VideoTagImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$VideoTagImplCopyWith<_$VideoTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
