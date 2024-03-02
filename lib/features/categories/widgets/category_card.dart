import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/filters.dart';
import '../model/category.dart';

class CategoryCard extends ConsumerWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color(0xff609966).withOpacity(0.85),
      margin: const EdgeInsets.all(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          ref.read(filtersProvider).setCategory(category);
        },
        child: Column(
          children: [
            const Expanded(child: Placeholder()),
            Text(
              category.categoryName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
