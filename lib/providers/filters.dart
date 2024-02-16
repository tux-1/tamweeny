import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/category.dart';

final filtersProvider = ChangeNotifierProvider((ref) => Filters());

class Filters extends ChangeNotifier {
  
  late final TabController tabController;

  Category? chosenCategory;

}
