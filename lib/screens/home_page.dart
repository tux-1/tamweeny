import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:tamweeny/generated/l10n.dart';

import 'categories/providers/categories_provider.dart';
import 'categories/providers/filters.dart';
import '../providers/products.dart';
import 'categories/widgets/category_chips.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/offer_item.dart';
import '../widgets/product_item.dart';

class HomePage extends riverpod.ConsumerStatefulWidget {
  const HomePage({super.key, this.scrollController});
  final ScrollController? scrollController;

  @override
  riverpod.ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends riverpod.ConsumerState<HomePage> {
  late ScrollController _controller;
  late Products productsData;

  void paginate() {
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(ref.read(filtersProvider).mostPopularIndex)
        .then((value) => ref.read(filtersProvider).mostPopularIndex++);
  }

  void _listen() {
    if (_controller.position.atEdge && mounted) {
      bool isTop = _controller.position.pixels == 0;
      if (isTop) {
        return;
      } else {
        paginate();
      }
    }
  }

  @override
  void initState() {
    paginate();
    super.initState();
    // Assigning controllers to widgets comes after initState
    _controller = widget.scrollController!;
    _controller.addListener(_listen);
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(categoriesFutureProvider);
    productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: _controller,
      slivers: [
        const CustomSearchBar(),

        SliverToBoxAdapter(
          child: CategoryChips(),
        ),

        SliverText(text: S.of(context).recommended_foods),

        // Recommended (horizontal scrollable sliver)
        SliverToBoxAdapter(
          child: SizedBox(
            height: 225,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: products[index],
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.45,
                        maxWidth: MediaQuery.of(context).size.width * 0.45,
                      ),
                      child: const ProductItem()),
                );
              },
            ),
          ),
        ),

        SliverText(text: S.of(context).offers),

        // Offers (horizontal scrollable sliver)
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: products[index],
                  child: OfferItem(),
                );
              },
            ),
          ),
        ),

        SliverText(text: S.of(context).most_popular),

        SliverPadding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          sliver: NotificationListener<ScrollEndNotification>(
            child: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.7,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                maxCrossAxisExtent: 300,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: products[index],
                  child: const ProductItem(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class SliverText extends StatelessWidget {
  const SliverText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
