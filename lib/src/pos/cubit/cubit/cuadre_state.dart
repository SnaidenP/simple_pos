part of 'cuadre_cubit.dart';

@freezed
class CuadreState with _$CuadreState {
  const factory CuadreState.initial() = _Initial;
  const factory CuadreState.loading() = _Loading;
  const factory CuadreState.loaded(List<Invoice> invoice) = _Loaded;
  const factory CuadreState.error(String message) = _Error;
}
