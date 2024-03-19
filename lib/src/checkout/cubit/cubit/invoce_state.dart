part of 'invoce_cubit.dart';

@freezed
class InvoceState with _$InvoceState {
  const factory InvoceState.initial() = _Initial;
  const factory InvoceState.loading() = _Loading;
  const factory InvoceState.success() = _Success;
  const factory InvoceState.loaded(Invoice invoice) = _Loaded;
  const factory InvoceState.error(String message) = _Error;
}
