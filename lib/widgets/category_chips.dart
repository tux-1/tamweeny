import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as prov;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/category.dart';
import '../providers/categories.dart';
import '../providers/filters.dart';

class CategoryChips extends ConsumerStatefulWidget {
  CategoryChips({super.key});

  @override
  ConsumerState<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends ConsumerState<CategoryChips> {
  Category? chosenCategory;

  @override
  void initState() {
    if (ref.read(filtersProvider).tabController.index == 3) {
      ref.read(filtersProvider).chosenCategory = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chosenCategory = ref.watch(filtersProvider).chosenCategory;
    final categoriesData = prov.Provider.of<CategoriesProvider>(context);
    final categories = categoriesData.items;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(spacing: 12, runSpacing: 10, children: [
        for (var category in categories)
          Card(
            color: const Color(0xff335145),
            margin: EdgeInsets.zero,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                setState(() {
                  ref.read(filtersProvider).chosenCategory = category;
                  ref.read(filtersProvider).tabController.animateTo(2);
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2),
                child: Text(
                  category.catName,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: chosenCategory == category
                          ? const Color(0xffDEA568)
                          : null),
                ),
              ),
            ),
          )
      ]),
    );
  }
}
