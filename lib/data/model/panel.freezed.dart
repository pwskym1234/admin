// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'panel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Panel _$PanelFromJson(Map<String, dynamic> json) {
  return _Panel.fromJson(json);
}

/// @nodoc
mixin _$Panel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get subscription_count => throw _privateConstructorUsedError;
  String get thumbnail_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PanelCopyWith<Panel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanelCopyWith<$Res> {
  factory $PanelCopyWith(Panel value, $Res Function(Panel) then) =
      _$PanelCopyWithImpl<$Res, Panel>;
  @useResult
  $Res call(
      {int id, String name, int subscription_count, String thumbnail_url});
}

/// @nodoc
class _$PanelCopyWithImpl<$Res, $Val extends Panel>
    implements $PanelCopyWith<$Res> {
  _$PanelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subscription_count = null,
    Object? thumbnail_url = null,
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
      subscription_count: null == subscription_count
          ? _value.subscription_count
          : subscription_count // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail_url: null == thumbnail_url
          ? _value.thumbnail_url
          : thumbnail_url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PanelImplCopyWith<$Res> implements $PanelCopyWith<$Res> {
  factory _$$PanelImplCopyWith(
          _$PanelImpl value, $Res Function(_$PanelImpl) then) =
      __$$PanelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String name, int subscription_count, String thumbnail_url});
}

/// @nodoc
class __$$PanelImplCopyWithImpl<$Res>
    extends _$PanelCopyWithImpl<$Res, _$PanelImpl>
    implements _$$PanelImplCopyWith<$Res> {
  __$$PanelImplCopyWithImpl(
      _$PanelImpl _value, $Res Function(_$PanelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? subscription_count = null,
    Object? thumbnail_url = null,
  }) {
    return _then(_$PanelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subscription_count: null == subscription_count
          ? _value.subscription_count
          : subscription_count // ignore: cast_nullable_to_non_nullable
              as int,
      thumbnail_url: null == thumbnail_url
          ? _value.thumbnail_url
          : thumbnail_url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PanelImpl implements _Panel {
  _$PanelImpl(
      {required this.id,
      required this.name,
      required this.subscription_count,
      required this.thumbnail_url});

  factory _$PanelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PanelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int subscription_count;
  @override
  final String thumbnail_url;

  @override
  String toString() {
    return 'Panel(id: $id, name: $name, subscription_count: $subscription_count, thumbnail_url: $thumbnail_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subscription_count, subscription_count) ||
                other.subscription_count == subscription_count) &&
            (identical(other.thumbnail_url, thumbnail_url) ||
                other.thumbnail_url == thumbnail_url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, subscription_count, thumbnail_url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PanelImplCopyWith<_$PanelImpl> get copyWith =>
      __$$PanelImplCopyWithImpl<_$PanelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PanelImplToJson(
      this,
    );
  }
}

abstract class _Panel implements Panel {
  factory _Panel(
      {required final int id,
      required final String name,
      required final int subscription_count,
      required final String thumbnail_url}) = _$PanelImpl;

  factory _Panel.fromJson(Map<String, dynamic> json) = _$PanelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get subscription_count;
  @override
  String get thumbnail_url;
  @override
  @JsonKey(ignore: true)
  _$$PanelImplCopyWith<_$PanelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
