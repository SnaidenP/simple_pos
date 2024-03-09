import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_pos/src/config/constants.dart';

class ProductsInCart extends StatelessWidget {
  const ProductsInCart({
    required this.productName,
    required this.quantity,
    required this.price,
    super.key,
    this.onTap,
    this.onLongPress,
  });

  final String productName;
  final int quantity;
  final double price;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              width: 120,
              height: 30,
              decoration: BoxDecoration(
                color: secondaryColor,
                border: Border.all(
                  color: secondaryColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  productName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: SizedBox(
              width: 90,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    quantity.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(width: 20),
          SizedBox(
            width: 80,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '\$${price.toStringAsFixed(2)}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
