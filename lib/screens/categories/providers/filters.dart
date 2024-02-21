import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/category.dart';

final filtersProvider = ChangeNotifierProvider((ref) => Filters());

class Filters extends ChangeNotifier {
  TabController? tabController;
  Category? chosenCategory;
  double scrollPosition = 0;
  int mostPopularIndex = 1;

  void clearCategory() {
    chosenCategory = null;
    scrollPosition = 0;
  }
}
