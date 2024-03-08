import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/categories_provider.dart';
import '../../providers/filters.dart';
import 'widgets/category_card.dart';
import 'widgets/category_chips.dart';
import '../../widgets/custom_search_bar.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenCategory = ref.watch(filtersProvider).chosenCategory;
    final categories = ref.watch(categoriesFutureProvider).value ?? [];

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: scrollController,
      slivers: chosenCategory == null
          ? [
              const CustomSearchBar(),
              SliverPadding(
                padding: const EdgeInsets.only(top: 11),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      category: categories[index],
                    );
                  },
                ),
              ),
            ]
          : [
              const CustomSearchBar(),
              SliverToBoxAdapter(
                child: CategoryChips(),
              ),
            ],
    );
  }
}
