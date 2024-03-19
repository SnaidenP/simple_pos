import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:simple_pos/src/checkout/models/client.dart';
import 'package:simple_pos/src/pos/models/products_in_cart.dart';

class Invoce {
  Invoce({
    required this.client,
    required this.products,
    required this.total,
    this.metodoPago = 'Efectivo',
    this.company = 'SnaidenP',
  });
  final String? company;
  final Client client;
  final List<ProductsInCart> products;
  final double total;
  final String? metodoPago;
}

// Clase para crear una factura en PDF
class PdfInvoice {
  final pdf = Document(
    author: '22-SISN-7-005',
    theme: ThemeData(
      defaultTextStyle: const TextStyle(
        fontSize: 10,
      ),
      tableHeader: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);
    return file;
  }

  static Future<void> openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  Future<void> buildHeader(Invoce invoce) async {
    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildTitle(invoce),
          buildClient(invoce),
          buildProducts(invoce),
          buildTotal(invoce),
        ],
      ),
    );
    final factura = await saveDocument(name: invoce.client.name, pdf: pdf);
    await openFile(factura);
  }

  Widget buildTitle(Invoce invoce) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Factura',
            style: const TextStyle(fontSize: 24),
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Text('Empresa: ${invoce.company}'),
        ],
      );

  Widget buildClient(Invoce invoce) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cliente: ${invoce.client.name}'),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Text('RNC: ${invoce.client.rnc}'),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Text('Teléfono: ${invoce.client.phone}'),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Text('Método de pago: ${invoce.metodoPago}'),
        ],
      );

  Widget buildProducts(Invoce invoce) {
    final headers = [
      'Producto',
      'Cantidad',
      'Precio',
      'Total',
    ];

    final data = invoce.products.map((product) {
      final total = product.price * product.quantity;
      return [
        product.name,
        product.quantity,
        '\$${product.price.toStringAsFixed(2)}',
        '\$${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return TableHelper.fromTextArray(
      headers: headers,
      data: data,
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
      },
    );
  }

  Widget buildTotal(Invoce invoce) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildTotalRow('Subtotal', invoce.total),
          buildTotalRow('ITBIS', invoce.total * 0.18),
          buildTotalRow('Total', invoce.total * 1.18),
        ],
      );

  Widget buildTotalRow(String description, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(description, style: const TextStyle(fontSize: 18)),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
