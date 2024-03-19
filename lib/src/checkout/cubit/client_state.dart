part of 'client_cubit.dart';

@freezed
class ClientState with _$ClientState {
  const factory ClientState.initial() = _Initial;
  const factory ClientState.loading() = _Loading;
  const factory ClientState.success(List<Client> clients) = _Success;
  const factory ClientState.error(String message) = _Error;
}
