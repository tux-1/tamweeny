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
    if (ref.read(filtersProvider).tabController!.index == 3) {
      ref.read(filtersProvider).chosenCategory = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    chosenCategory = ref.watch(filtersProvider).chosenCategory;
    final categoriesData = prov.Provider.of<CategoriesProvider>(context);
    final categories = categoriesData.items;
    return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              color: const Color(0xff335145),
              margin: const EdgeInsets.symmetric(horizontal: 5),
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  setState(() {
                    ref.read(filtersProvider).chosenCategory = category;
                    ref.read(filtersProvider).tabController!.animateTo(2);
                  });
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: Text(
                    category.categoryName,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: chosenCategory == category
                            ? const Color(0xffDEA568)
                            : null),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
