import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/pos/data/repository.dart';
import 'package:simple_pos/src/pos/models/product.dart';

part 'cuadre_state.dart';
part 'cuadre_cubit.freezed.dart';

class CuadreCubit extends Cubit<CuadreState> {
  CuadreCubit(this.repository) : super(const CuadreState.initial());

  final ProductsRepository repository;
  Future<void> loadInvoices() async {
    emit(const CuadreState.loading());
    try {
      final results = await repository.getInvoices();
      emit(CuadreState.loaded(results));
    } catch (e) {
      emit(CuadreState.error(e.toString()));
    }
  }
}
