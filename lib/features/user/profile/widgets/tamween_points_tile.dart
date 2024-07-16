import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../providers/account_info.dart';

class TamweenPointsTile extends ConsumerWidget {
  const TamweenPointsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(accountInfoProvider);
    return userData.when(
      data: (data) => ListTile(
        leading: const Icon(Icons.wallet),
        title: Text(S.of(context).wallet_balance),
        trailing: Text(data['tamweenPoints'].toString()),
      ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => ListTile(
        leading: const Icon(Icons.wallet),
        title: Text(S.of(context).wallet_balance),
      ),
    );
  }
}
