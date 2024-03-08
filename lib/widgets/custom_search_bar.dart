import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../features/cart/cart_screen.dart';
import '../generated/l10n.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                      delegate:
                          CustomSearchDelegate(hintText: S.of(context).search),
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

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    //Should be queried from database
    'Apple',
    'Banana',
    'Pear',
    'Salama',
    'Mahnod',
    'Strawberry',
    'Watermelon',
  ];

  CustomSearchDelegate({
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
          },
          icon: const Icon(
            Icons.clear,
          )),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var item in searchTerms) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          if (query.isNotEmpty) {
            return ListTile(
              title: Text(result),
            );
          } else {
            return null;
            // Add recent searches here ??
          }
        });
  }
}
