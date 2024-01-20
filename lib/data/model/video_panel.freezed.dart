// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_panel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VideoPanel _$VideoPanelFromJson(Map<String, dynamic> json) {
  return _VideoPanel.fromJson(json);
}

/// @nodoc
mixin _$VideoPanel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VideoPanelCopyWith<VideoPanel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoPanelCopyWith<$Res> {
  factory $VideoPanelCopyWith(
          VideoPanel value, $Res Function(VideoPanel) then) =
      _$VideoPanelCopyWithImpl<$Res, VideoPanel>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$VideoPanelCopyWithImpl<$Res, $Val extends VideoPanel>
    implements $VideoPanelCopyWith<$Res> {
  _$VideoPanelCopyWithImpl(this._value, this._then);

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
abstract class _$$VideoPanelImplCopyWith<$Res>
    implements $VideoPanelCopyWith<$Res> {
  factory _$$VideoPanelImplCopyWith(
          _$VideoPanelImpl value, $Res Function(_$VideoPanelImpl) then) =
      __$$VideoPanelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$VideoPanelImplCopyWithImpl<$Res>
    extends _$VideoPanelCopyWithImpl<$Res, _$VideoPanelImpl>
    implements _$$VideoPanelImplCopyWith<$Res> {
  __$$VideoPanelImplCopyWithImpl(
      _$VideoPanelImpl _value, $Res Function(_$VideoPanelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$VideoPanelImpl(
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
class _$VideoPanelImpl implements _VideoPanel {
  _$VideoPanelImpl({required this.id, required this.name});

  factory _$VideoPanelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoPanelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'VideoPanel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoPanelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoPanelImplCopyWith<_$VideoPanelImpl> get copyWith =>
      __$$VideoPanelImplCopyWithImpl<_$VideoPanelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoPanelImplToJson(
      this,
    );
  }
}

abstract class _VideoPanel implements VideoPanel {
  factory _VideoPanel({required final int id, required final String name}) =
      _$VideoPanelImpl;

  factory _VideoPanel.fromJson(Map<String, dynamic> json) =
      _$VideoPanelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$VideoPanelImplCopyWith<_$VideoPanelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
