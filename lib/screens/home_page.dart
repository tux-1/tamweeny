import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../providers/products.dart';
import '../widgets/custom_scaffold.dart';
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
    super.initState();
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
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return CustomScaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: _controller,
          slivers: [
            const CustomSearchBar(),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).recommended_foods,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Recommended (horizontal scrollable sliver)
            SliverToBoxAdapter(
              child: SizedBox(
                height: 225,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: products[index],
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
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

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).offers,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Offers (horizontal scrollable sliver)
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
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

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S.of(context).most_popular,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 11,
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
      ),
    );
  }
}
