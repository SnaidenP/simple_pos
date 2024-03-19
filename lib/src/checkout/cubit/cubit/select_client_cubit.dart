import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/checkout/models/client.dart';

part 'select_client_state.dart';
part 'select_client_cubit.freezed.dart';

class SelectClientCubit extends Cubit<SelectClientState> {
  SelectClientCubit() : super(const SelectClientState.initial());

  // load client
  Future<void> loadClient(Client client) async {
    print('client Loaded: $client');
    emit(SelectClientState.loaded(client));
  }
}
