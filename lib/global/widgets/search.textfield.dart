import 'package:flutter/material.dart';
import 'package:portfolio/generated/l10n.dart';
import 'package:portfolio_ds/lib.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: const BoxConstraints(maxWidth: 250, maxHeight: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: context.colors.primary.withOpacity(0.4),
        ),
        child: TextField(
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
          onChanged: (value) {},
          cursorHeight: 15,
          decoration: InputDecoration(
            constraints: const BoxConstraints(),
            prefixIcon: const Icon(Icons.search),
            hintText: S.of(context).search,
            prefixIconColor: context.colors.onPrimary,
            hintStyle: TextStyle(
              color: context.colors.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(90),
            ),
          ),
        ));
  }
}
