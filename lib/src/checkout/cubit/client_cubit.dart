import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/checkout/models/client.dart';

part 'client_state.dart';
part 'client_cubit.freezed.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit(this.repository) : super(const ClientState.initial());

  final CheckoutRepository repository;

  // search clients
  Future<void> getClients([String? client]) async {
    emit(const ClientState.loading());
    try {
      final clients = await repository.getClients(client);
      emit(ClientState.success(clients));
    } catch (e) {
      emit(ClientState.error(e.toString()));
    }
  }

  // select client
  void selectClient(Client client) {
    emit(ClientState.success([client]));
  }

  // create client
  Future<void> createClient(Client client) async {
    emit(const ClientState.loading());
    try {
      await repository.createClient(client);
      emit(ClientState.success([client]));
    } catch (e) {
      emit(ClientState.error(e.toString()));
    }
  }
}
