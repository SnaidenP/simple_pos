import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_pos/src/config/constants.dart';

class SearchProductField extends StatefulWidget {
  const SearchProductField({required this.onChanged, super.key});

  final void Function(String) onChanged;

  @override
  State<SearchProductField> createState() => _SearchProductFieldState();
}

class _SearchProductFieldState extends State<SearchProductField> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width / 4.5,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onChanged: (text) {
            _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              widget.onChanged(text);
            });
          },
          decoration: InputDecoration(
            labelText: 'Buscar producto',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
