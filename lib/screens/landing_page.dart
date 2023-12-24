import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landing-page';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
    if (!_isVisible) {
      setState(() => _isVisible = true);
    }
  }

  void _hide() {
    if (_isVisible) {
      setState(() => _isVisible = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_listen);
  }

  @override
  void dispose() {
    _controller.removeListener(_listen);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    // final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: _isVisible
          ? FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 218, 218, 218),
              foregroundColor: const Color.fromARGB(255, 30, 53, 47),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate:
                      CustomSearchDelegate(hintText: S.of(context).search),
                );
              },
              child: const Icon(Icons.search),
            )
          : null,
      backgroundColor: const Color.fromARGB(204, 187, 204, 187),
      body: ListView(
        controller: _controller,
        children: [
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: products[index],
                child: const ProductItem(),
              );
            },
          ),
          Container(
            height: 500,
            color: const Color.fromARGB(122, 96, 125, 139),
            child: const Text(
              'Test',
              textAlign: TextAlign.center,
            ),
          )
        ],
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
