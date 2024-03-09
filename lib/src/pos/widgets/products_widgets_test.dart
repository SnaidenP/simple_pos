import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_pos/src/pos/widgets/products_widgets.dart';

void main() {
  testWidgets('Product widget test', (WidgetTester tester) async {
    // Build the product widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductWidget(
            productName: 'Test Product',
            productType: 'Test Type',
            productStock: 10,
            productPrice: 9.99,
          ),
        ),
      ),
    );

    // Verify that the product name is displayed correctly
    expect(find.text('Test Product'), findsOneWidget);

    // Verify that the product type is displayed correctly
    expect(find.text('Test Type'), findsOneWidget);

    // Verify that the product stock is displayed correctly
    expect(find.text('10'), findsOneWidget);

    // Verify that the product price is displayed correctly
    expect(find.text(r'$9.99'), findsOneWidget);
  });
}
