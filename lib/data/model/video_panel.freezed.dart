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
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoPanelCopyWith<$Res> {
  factory $VideoPanelCopyWith(
          VideoPanel value, $Res Function(VideoPanel) then) =
      _$VideoPanelCopyWithImpl<$Res, VideoPanel>;
}

/// @nodoc
class _$VideoPanelCopyWithImpl<$Res, $Val extends VideoPanel>
    implements $VideoPanelCopyWith<$Res> {
  _$VideoPanelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$VideoPanelImplCopyWith<$Res> {
  factory _$$VideoPanelImplCopyWith(
          _$VideoPanelImpl value, $Res Function(_$VideoPanelImpl) then) =
      __$$VideoPanelImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VideoPanelImplCopyWithImpl<$Res>
    extends _$VideoPanelCopyWithImpl<$Res, _$VideoPanelImpl>
    implements _$$VideoPanelImplCopyWith<$Res> {
  __$$VideoPanelImplCopyWithImpl(
      _$VideoPanelImpl _value, $Res Function(_$VideoPanelImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$VideoPanelImpl implements _VideoPanel {
  _$VideoPanelImpl();

  factory _$VideoPanelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoPanelImplFromJson(json);

  @override
  String toString() {
    return 'VideoPanel()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VideoPanelImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoPanelImplToJson(
      this,
    );
  }
}

abstract class _VideoPanel implements VideoPanel {
  factory _VideoPanel() = _$VideoPanelImpl;

  factory _VideoPanel.fromJson(Map<String, dynamic> json) =
      _$VideoPanelImpl.fromJson;
}
