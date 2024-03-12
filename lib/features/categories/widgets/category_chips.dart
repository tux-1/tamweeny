import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Models/category.dart';
import '../../../providers/categories.dart';
import '../../../providers/category_products.dart';
import '../../../providers/filters.dart';

class CategoryChips extends ConsumerStatefulWidget {
  const CategoryChips({super.key});

  @override
  ConsumerState<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends ConsumerState<CategoryChips> {
  Category? chosenCategory;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    if (ref.read(filtersProvider).tabController?.index == 3) {
      ref.read(filtersProvider).clearCategory();
    }
    _scrollController = ScrollController(
      initialScrollOffset: ref.read(filtersProvider).scrollPosition,
    );
  }

  @override
  Widget build(BuildContext context) {
    chosenCategory = ref.watch(filtersProvider).chosenCategory;
    final categories = ref.watch(categoriesFutureProvider).value ?? [];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 80,
      child: ListView.builder(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: 75,
            decoration: const BoxDecoration(),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            clipBehavior: Clip.antiAlias,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  ref.read(filtersProvider).setCategory(category);
                  ref.read(filtersProvider).scrollPosition =
                      _scrollController.position.pixels;
                  ref.read(filtersProvider).tabController?.index = 2;
                });
                ref
                    .read(asyncCategoryItemsProvider.notifier)
                    .getCategoryProducts(category.categoryName);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        category.categoryIcon,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                  Text(
                    category.categoryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: chosenCategory == category
                              ? const Color(0xffDEA568)
                              : null,
                        ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
