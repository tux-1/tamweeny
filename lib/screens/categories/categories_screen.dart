import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/categories_provider.dart';
import 'providers/filters.dart';
import 'widgets/category_chips.dart';
import '../../widgets/custom_search_bar.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key, required this.scrollController});
  final ScrollController scrollController;

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chosenCategory = ref.watch(filtersProvider).chosenCategory;
    final categories = ref.watch(categoriesFutureProvider).value ?? [];

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: widget.scrollController,
      slivers: chosenCategory == null
          ? [
              const CustomSearchBar(),
              SliverGrid.builder(
                gridDelegate:
                    const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 500,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xffDEA568).withOpacity(0.85),
                    margin: const EdgeInsets.all(22),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          ref.read(filtersProvider).chosenCategory =
                              categories[index];
                        });
                        categories[index];
                      },
                      child: Column(
                        children: [
                          const Expanded(child: Placeholder()),
                          Text(
                            categories[index].categoryName,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
