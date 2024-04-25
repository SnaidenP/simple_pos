// Model NCFType using Freezed

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ncftype.freezed.dart';
part 'ncftype.g.dart';

@freezed
class NcfType with _$NcfType {
  const factory NcfType({
    required int id,
    required String tipo,
    required int constante,
    required String numeroInicial,
    required int limite,
  }) = _NcfType;

  factory NcfType.fromJson(Map<String, dynamic> json) =>
      _$NcfTypeFromJson(json);
}
