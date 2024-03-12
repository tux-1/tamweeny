import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tamweeny/providers/filters.dart';
import 'package:tamweeny/providers/search.dart';
import 'package:tamweeny/widgets/product_item.dart';

import '../features/cart/cart_screen.dart';
import '../generated/l10n.dart';

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: const Color(0xff2D2D2D)),
                child: TextField(
                  onTap: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(
                        ref: ref,
                        hintText: S.of(context).search,
                      ),
                    );
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: const Color(0xff2D2D2D),
                    hintText: S.of(context).search,
                    hintStyle: Theme.of(context).textTheme.headlineMedium,
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Ionicons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: const Color(0xff2D2D2D)),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const CartScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Ionicons.cart,
                    size: 27,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

final x = GlobalKey();

class CustomSearchDelegate extends SearchDelegate {
  final WidgetRef ref;

  CustomSearchDelegate({
    required this.ref,
    hintText,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          ref.read(filtersProvider).searchQuery = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          ref.read(filtersProvider).searchQuery = '';
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    ref.read(filtersProvider).searchQuery = query;

    final searchTermsFuture = ref.refresh(searchProvider.future);

    return PopScope(
      onPopInvoked: (didPop) {
        ref.read(filtersProvider).searchQuery = '';
      },
      child: FutureBuilder(
        future: searchTermsFuture,
        builder: (context, snapshot) => GridView.builder(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 0.7,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            maxCrossAxisExtent: 300,
          ),
          itemCount: snapshot.data?.length ?? 1,
          itemBuilder: (context, index) {
            if (snapshot.hasData) {
              return ProductItem(snapshot.requireData[index]);
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}
