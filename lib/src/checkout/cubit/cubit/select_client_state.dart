part of 'select_client_cubit.dart';

@freezed
class SelectClientState with _$SelectClientState {
  const factory SelectClientState.initial() = _Initial;
  const factory SelectClientState.loading() = _Loading;
  const factory SelectClientState.loaded(Client client) = _Loaded;
}
