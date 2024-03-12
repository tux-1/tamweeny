import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/category.dart';

final filtersProvider = ChangeNotifierProvider((ref) => Filters());

class Filters extends ChangeNotifier {
  TabController? tabController;
  Category? chosenCategory;
  double scrollPosition = 0;
  int mostPopularPaginationIndex = 2;
  String searchQuery = '';

  void setCategory(Category category) {
    chosenCategory = category;
    notifyListeners();
  }

  void clearCategory() {
    chosenCategory = null;
    scrollPosition = 0;
  }
}
