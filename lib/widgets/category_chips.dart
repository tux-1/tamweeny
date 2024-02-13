import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/categories.dart';

class CategoryChips extends StatelessWidget {
  CategoryChips({super.key});

  late final CategoriesProvider categoriesData;

  @override
  Widget build(BuildContext context) {
    categoriesData = Provider.of<CategoriesProvider>(context);
    final categories = categoriesData.items;
    return Wrap(children: [
      for (var category in categories)
        Card(
          color: const Color(0xff335145),
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:4.0, vertical: 2),
              child: Text(category.catName),
            ),
          ),
        )
    ]);
  }
}
