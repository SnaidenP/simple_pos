// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ncftype.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NcfType _$NcfTypeFromJson(Map<String, dynamic> json) {
  return _NcfType.fromJson(json);
}

/// @nodoc
mixin _$NcfType {
  int get id => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  int get constante => throw _privateConstructorUsedError;
  String get numeroInicial => throw _privateConstructorUsedError;
  int get limite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NcfTypeCopyWith<NcfType> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NcfTypeCopyWith<$Res> {
  factory $NcfTypeCopyWith(NcfType value, $Res Function(NcfType) then) =
      _$NcfTypeCopyWithImpl<$Res, NcfType>;
  @useResult
  $Res call(
      {int id, String tipo, int constante, String numeroInicial, int limite});
}

/// @nodoc
class _$NcfTypeCopyWithImpl<$Res, $Val extends NcfType>
    implements $NcfTypeCopyWith<$Res> {
  _$NcfTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tipo = null,
    Object? constante = null,
    Object? numeroInicial = null,
    Object? limite = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      constante: null == constante
          ? _value.constante
          : constante // ignore: cast_nullable_to_non_nullable
              as int,
      numeroInicial: null == numeroInicial
          ? _value.numeroInicial
          : numeroInicial // ignore: cast_nullable_to_non_nullable
              as String,
      limite: null == limite
          ? _value.limite
          : limite // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NcfTypeImplCopyWith<$Res> implements $NcfTypeCopyWith<$Res> {
  factory _$$NcfTypeImplCopyWith(
          _$NcfTypeImpl value, $Res Function(_$NcfTypeImpl) then) =
      __$$NcfTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String tipo, int constante, String numeroInicial, int limite});
}

/// @nodoc
class __$$NcfTypeImplCopyWithImpl<$Res>
    extends _$NcfTypeCopyWithImpl<$Res, _$NcfTypeImpl>
    implements _$$NcfTypeImplCopyWith<$Res> {
  __$$NcfTypeImplCopyWithImpl(
      _$NcfTypeImpl _value, $Res Function(_$NcfTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tipo = null,
    Object? constante = null,
    Object? numeroInicial = null,
    Object? limite = null,
  }) {
    return _then(_$NcfTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tipo: null == tipo
          ? _value.tipo
          : tipo // ignore: cast_nullable_to_non_nullable
              as String,
      constante: null == constante
          ? _value.constante
          : constante // ignore: cast_nullable_to_non_nullable
              as int,
      numeroInicial: null == numeroInicial
          ? _value.numeroInicial
          : numeroInicial // ignore: cast_nullable_to_non_nullable
              as String,
      limite: null == limite
          ? _value.limite
          : limite // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NcfTypeImpl implements _NcfType {
  const _$NcfTypeImpl(
      {required this.id,
      required this.tipo,
      required this.constante,
      required this.numeroInicial,
      required this.limite});

  factory _$NcfTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$NcfTypeImplFromJson(json);

  @override
  final int id;
  @override
  final String tipo;
  @override
  final int constante;
  @override
  final String numeroInicial;
  @override
  final int limite;

  @override
  String toString() {
    return 'NcfType(id: $id, tipo: $tipo, constante: $constante, numeroInicial: $numeroInicial, limite: $limite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NcfTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            (identical(other.constante, constante) ||
                other.constante == constante) &&
            (identical(other.numeroInicial, numeroInicial) ||
                other.numeroInicial == numeroInicial) &&
            (identical(other.limite, limite) || other.limite == limite));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, tipo, constante, numeroInicial, limite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NcfTypeImplCopyWith<_$NcfTypeImpl> get copyWith =>
      __$$NcfTypeImplCopyWithImpl<_$NcfTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NcfTypeImplToJson(
      this,
    );
  }
}

abstract class _NcfType implements NcfType {
  const factory _NcfType(
      {required final int id,
      required final String tipo,
      required final int constante,
      required final String numeroInicial,
      required final int limite}) = _$NcfTypeImpl;

  factory _NcfType.fromJson(Map<String, dynamic> json) = _$NcfTypeImpl.fromJson;

  @override
  int get id;
  @override
  String get tipo;
  @override
  int get constante;
  @override
  String get numeroInicial;
  @override
  int get limite;
  @override
  @JsonKey(ignore: true)
  _$$NcfTypeImplCopyWith<_$NcfTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
