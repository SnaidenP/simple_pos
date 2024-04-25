import 'dart:io';
import 'dart:ui';

import 'package:date_time_format/date_time_format.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_image_generator/qr_image_generator.dart';
import 'package:simple_pos/src/checkout/models/client.dart';
import 'package:simple_pos/src/checkout/models/invoce.dart';
import 'package:simple_pos/src/pos/models/products_in_cart.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Invoce {
  Invoce({
    required this.client,
    required this.products,
    required this.total,
    this.metodoPago = 'Efectivo',
    this.company = 'SnaidenP',
    this.ncf,
  });
  final String? company;
  final Client client;
  final String? ncf;
  final List<ProductsInCart> products;
  final double total;
  final String? metodoPago;
}

// Clase para crear una factura en PDF
class PdfInvoice {
  Future<void> generatePDF(Invoce invoice) async {
    //Create a PDF document.
    final document = PdfDocument();
    //Add page to the PDF
    final page = document.pages.add();
    //Get page client size
    final pageSize = page.getClientSize();
    //Draw rectangle
    // page.graphics.drawRectangle(
    //   bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
    //   pen: PdfPen(PdfColor(142, 170, 219)),
    // );
    //Generate PDF grid.
    final grid = _getGrid(invoice);
    //Draw the header section by creating text element
    final result = await _drawHeader(page, pageSize, grid, invoice);
    //Draw grid
    _drawGrid(page, grid, result);
    //Add invoice footer
    await _drawFooter(page, pageSize, invoice);
    //Save and dispose the document.
    final bytes = await document.save();
    document.dispose();
    //Launch file.
    // OpenFile
    final path = (await getApplicationDocumentsDirectory()).path;
    final file = File('$path/invoice.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  //Draws the invoice header
  Future<PdfLayoutResult> _drawHeader(
    PdfPage page,
    Size pageSize,
    PdfGrid grid,
    Invoce invoce,
  ) async {
    //Draw rectangle
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(32, 32, 32)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90),
    );
    //Draw string
    page.graphics.drawString(
      'FACTURA\n',
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle),
    );
    // Set the company name on the header
    page.graphics.drawString(
      invoce.company!,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(25, 30, pageSize.width - 115, 90),
      format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle),
    );
    page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
      brush: PdfSolidBrush(PdfColor(64, 64, 64)),
    );
    page.graphics.drawString(
      r'$' + invoce.total.toStringAsFixed(2),
      PdfStandardFont(PdfFontFamily.helvetica, 18),
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
      brush: PdfBrushes.white,
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle,
      ),
    );
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Draw string
    page.graphics.drawString(
      'TOTAL',
      contentFont,
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 33),
      format: PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.bottom,
      ),
    );
    //Create data foramt and convert it to text.
    final format = DateTimeFormat.format(
      DateTime.now(),
      format: DateTimeFormats.europeanAbbr,
    );
    final invoiceNumber = 'NFC: ${invoce.ncf}\r\n\r\nFecha: $format';
    final contentSize = contentFont.measureString(invoiceNumber);
    //  'Bill To: \r\n\r\nAbraham Swearegin, \r\n\r\nUnited States, California, San Mateo, \r\n\r\n9920 BridgePointe Parkway, \r\n\r\n9365550136';
    final datosCliente =
        'Cliente: ${invoce.client.name}\r\n\r\nRNC: ${invoce.client.rnc}\r\n\r\nTelefono: ${invoce.client.phone}\r\n\r\nMetodo de Pago: ${invoce.metodoPago}';

    PdfTextElement(text: invoiceNumber, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
        pageSize.width - (contentSize.width + 30),
        120,
        contentSize.width + 30,
        pageSize.height - 120,
      ),
    );
    return PdfTextElement(text: datosCliente, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(
        30,
        120,
        pageSize.width - (contentSize.width + 30),
        pageSize.height - 120,
      ),
    )!;
  }

  //Draws the grid
  void _drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0),
    )!;
  }

  //Draw the invoice footer data.
  Future<void> _drawFooter(PdfPage page, Size pageSize, Invoce invoce) async {
    final linePen =
        PdfPen(PdfColor(32, 32, 32), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(
      linePen,
      Offset(0, pageSize.height - 100),
      Offset(pageSize.width, pageSize.height - 100),
    );
    const footerContent =
        'Gracias por comprar con nosotros.\r\n\r\nEsta factura vence en 30 días.';
    //Added 30 as a margin for the layout
    page.graphics.drawString(
      footerContent,
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      bounds: Rect.fromLTWH(pageSize.width - 30, pageSize.height - 70, 0, 0),
    );

    // add Qr code to the pdf
    final qrCode = QRGenerator();
    final path = (await getApplicationDocumentsDirectory()).path;
    final qrImage = await qrCode.generate(
      data: invoce.ncf!,
      filePath: '$path/invoice_qr.png',
    );

    // add qr code to the pdf al final de la factura del lado izquierdo
    final imageData = File(qrImage).readAsBytesSync();
    final image = PdfBitmap(imageData);
    page.graphics.drawImage(
      image,
      Rect.fromLTWH(30, pageSize.height - 70, 50, 50),
    );
  }

  //Create PDF grid and return
  PdfGrid _getGrid(Invoce invoice) {
    //Create a PDF grid
    final grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 5);
    //Create the header row of the grid.
    final headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(32, 32, 32));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'ID';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'Nombre del Producto';
    headerRow.cells[2].value = 'Precio';
    headerRow.cells[3].value = 'Cantidad';
    headerRow.cells[4].value = 'Total';

    for (final element in invoice.products) {
      _addProducts(
        element.id.toString(),
        element.name,
        element.price,
        element.quantity,
        element.price * element.quantity,
        grid,
      );
    }

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    grid.columns[1].width = 200;
    for (var i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (var i = 0; i < grid.rows.count; i++) {
      final row = grid.rows[i];
      for (var j = 0; j < row.cells.count; j++) {
        final cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  //Create and row for the grid.
  void _addProducts(
    String productId,
    String productName,
    double price,
    int quantity,
    double total,
    PdfGrid grid,
  ) {
    final row = grid.rows.add();
    row.cells[0].value = productId;
    row.cells[1].value = productName;
    row.cells[2].value = price.toString();
    row.cells[3].value = quantity.toString();
    row.cells[4].value = total.toString();
  }

  //Get the total amount.
  double _getTotalAmount(PdfGrid grid) {
    var total = 0.0;
    for (var i = 0; i < grid.rows.count; i++) {
      final value = grid.rows[i].cells[grid.columns.count - 1].value as String;
      total += double.parse(value);
    }
    return total;
  }
}
