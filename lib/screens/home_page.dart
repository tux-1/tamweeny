import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../providers/products.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/offer_item.dart';
import '../widgets/product_item.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/landing-page';
  const HomePage({super.key, this.scrollController});
  final ScrollController? scrollController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _controller;
  late Products productsData;
  bool _isVisible = true;

  void _listen() {
    final ScrollDirection direction = _controller.position.userScrollDirection;

    if (direction == ScrollDirection.forward) {
      _show();
    } else if (direction == ScrollDirection.reverse) {
      _hide();
    }
  }

  void _show() {
    if (!_isVisible && mounted) {
      setState(() => _isVisible = true);
    }
  }

  void _hide() {
    if (_isVisible && mounted) {
      setState(() => _isVisible = false);
    }
  }

  @override
  void initState() {
    Provider.of<Products>(context, listen: false).fetchAndSetProducts(1);
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
    productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return SafeArea(
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: _controller,
        slivers: [
          const CustomSearchBar(),
          

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
            sliver: SliverGrid.builder(
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
        ],
      ),
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
