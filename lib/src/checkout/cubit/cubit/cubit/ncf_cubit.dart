import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/checkout/models/ncftype.dart';
import 'package:simple_pos/src/config/database.dart';

part 'ncf_state.dart';
part 'ncf_cubit.freezed.dart';

class NcfCubit extends Cubit<NcfState> {
  NcfCubit(this.repository) : super(const NcfState.initial());

  final CheckoutRepository repository;
  // Search Ncf
  Future<void> loadNcf([String? ncf]) async {
    try {
      final results = await repository.getNfcTypes(ncf);
      emit(NcfState.loaded(results));
    } catch (e) {
      emit(NcfState.error(e.toString()));
    }
  }

  // Update Ncf
  Future<void> updateNcf(String ncfType) async {
    try {
      await repository.updateNcfType(ncfType);
    } catch (e) {
      emit(NcfState.error(e.toString()));
    }
  }
}
