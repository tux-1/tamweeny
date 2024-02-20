import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../providers/categories.dart';
import '../providers/products.dart';
import '../widgets/category_chips.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/offer_item.dart';
import '../widgets/product_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.scrollController});
  final ScrollController? scrollController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;
  late Products productsData;

  @override
  void initState() {
    Provider.of<Products>(context, listen: false).fetchAndSetProducts(1);
    Provider.of<CategoriesProvider>(context, listen: false)
        .fetchAndSetCategories();
    super.initState();
    // Assigning controllers to widgets comes after initState
    _controller = widget.scrollController!;
    _controller.addListener(() {
      if (_controller.position.atEdge ) {
      bool isTop = _controller.position.pixels == 0;
      if (isTop) {
        print('At the top');
      } else {
        print('At the bottom');
      }
    }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
