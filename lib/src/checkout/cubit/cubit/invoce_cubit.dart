import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_pos/src/checkout/data/repository.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/config/pdf_invoce.dart';

part 'invoce_state.dart';
part 'invoce_cubit.freezed.dart';

class InvoceCubit extends Cubit<InvoceState> {
  InvoceCubit(this.repository) : super(const InvoceState.initial());

  final CheckoutRepository repository;
  final pdfInvoice = PdfInvoice();

  //create pdf
  Future<void> createPdf(Invoce invoice) async {
    emit(const InvoceState.loading());
    try {
      await PdfInvoice().buildHeader(invoice);
      emit(const InvoceState.success());
    } catch (e) {
      emit(InvoceState.error(e.toString()));
    }
  }

  // create invoice
  Future<void> createInvoice(Invoice invoice) async {
    emit(const InvoceState.loading());
    try {
      print('invoice: $invoice');
      final results = await repository.createInvoice(invoice);
      print(results.affectedRows);

      emit(const InvoceState.success());
    } catch (e) {
      emit(InvoceState.error(e.toString()));
    }
  }

  // load invoice
  Future<void> loadInvoice(Invoice invoice) async {
    emit(InvoceState.loaded(invoice));
  }
}
