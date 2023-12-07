import 'package:flutter/material.dart';
import 'package:tamweeny/widgets/custom_appbar.dart';

import '../widgets/custom_scaffold.dart';

class LocationsScreen extends StatelessWidget {
  static const routeName = '/locations-screen';

  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        bottomNavigationBar: const CustomBottomAppBar(isVisible: true),
        body: Text('hi')
        );
  }
}
