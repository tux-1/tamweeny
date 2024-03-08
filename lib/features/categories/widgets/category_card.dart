import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/category_products.dart';
import '../../../providers/filters.dart';
import '../../../Models/category.dart';

class CategoryCard extends ConsumerWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color(0xff345E37),
      margin: const EdgeInsets.all(13),
      elevation: 6,
      shadowColor: const Color(0xff70B5FF).withOpacity(0.3),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ref.read(filtersProvider).setCategory(category);
          ref
              .read(asyncCategoryItemsProvider.notifier)
              .getCategoryProducts(category.categoryName);
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                category.categoryImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const SizedBox();
                },
                
              ),
            ),
            const SizedBox.expand(
              child: ColoredBox(
                color: Color.fromARGB(78, 0, 0, 0),
              ),
            ),
            Positioned(
              child: Center(
                child: Text(
                  category.categoryName,
                  maxLines: 2,
                  textWidthBasis: TextWidthBasis.longestLine,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
