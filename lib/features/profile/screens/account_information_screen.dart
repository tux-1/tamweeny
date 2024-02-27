import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/l10n.dart';
import '../../../widgets/custom_scaffold.dart';

class AccountInformationScreen extends ConsumerWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).account_information,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Column(
        
      ),
    );
  }
}
