import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/generated/l10n.dart';
import 'package:tamweeny/providers/recommended_products.dart';

import '../../providers/categories.dart';
import '../../providers/filters.dart';
import '../../providers/offers.dart';
import '../../providers/products.dart';
import 'categories/widgets/category_chips.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/product_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.scrollController});
  final ScrollController? scrollController;

  @override
  ConsumerState<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen> {
  late ScrollController _controller;

  void paginate() {
    ref
        .read(asyncProductsProvider.notifier)
        .getNextProducts(ref.read(filtersProvider).mostPopularPaginationIndex)
        .then((value) {
      setState(() {});
    });
  }

  void _paginationListener() {
    if (_controller.position.extentAfter < 100 && mounted) {
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
    super.initState();
    _controller = widget.scrollController!;
    _controller.addListener(_paginationListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_paginationListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(categoriesFutureProvider);
    final products = ref.watch(asyncProductsProvider).value ?? [];
    final offersData = ref.watch(offersProvider);
    final recommendedProducts = ref.watch(recommendedProductsProvder);

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      controller: _controller,
      slivers: [
        const CustomSearchBar(),

        const SliverToBoxAdapter(
          child: CategoryChips(),
        ),

        SliverText(text: S.of(context).recommended_foods),

        // Recommended (horizontal scrollable sliver)
        recommendedProducts.when(
          data: (data) => SliverToBoxAdapter(
            child: SizedBox(
              height: 225,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.45,
                      maxWidth: MediaQuery.of(context).size.width * 0.45,
                    ),
                    child: ProductItem(data[index]),
                  );
                },
              ),
            ),
          ),
          error: (error, stackTrace) {
            return SliverToBoxAdapter(
              child: Text(
                S.of(context).an_error_occurred,
                textAlign: TextAlign.center,
              ),
            );
          },
          loading: () => const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),

        SliverText(text: S.of(context).out_of_tamween),

        // Offers (horizontal scrollable sliver)
        offersData.when(
          data: (offers) => SliverToBoxAdapter(
            child: SizedBox(
              height: 225,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.45,
                      maxWidth: MediaQuery.of(context).size.width * 0.45,
                    ),
                    child: ProductItem(offers[index]),
                  );
                },
              ),
            ),
          ),
          error: (error, stackTrace) => SliverToBoxAdapter(
            child: Text(
              S.of(context).an_error_occurred,
              textAlign: TextAlign.center,
            ),
          ),
          loading: () => const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),

        SliverText(text: S.of(context).tamween_products),

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
                return ProductItem(products[index]);
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
