import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_pos/src/pos/widgets/products_widgets.dart';
import 'package:simple_pos/src/pos/widgets/sidebar.dart';

class PosScreen extends StatelessWidget {
  const PosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const SideBar(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PUNTO DE VENTA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // GridView for 5 products
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        // hide scroolbar

                        children: List.generate(
                          10,
                          (index) {
                            return ProductsWidget(
                              productName: 'PAN ANTILLA $index',
                              productType: 'UNIDAD',
                              productPrice: 0.50,
                              productStock: 10,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const Text('POS Screen'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
