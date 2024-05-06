import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/l10n.dart';
import '../../../../providers/auth.dart';
import '../../../authentication/screens/logIn_screen.dart';

class LogOutListTile extends ConsumerWidget {
  const LogOutListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: Text(S.of(context).sign_out),
      onTap: () async {
        final navigator = Navigator.of(context);
        await ref.read(authProvider).logOut().then((value) {
          navigator.pushReplacementNamed(LogInScreen.routeName);
        }).onError((error, _) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text('Request timed out.'),
                );
              });
        });
      },
    );
  }
}
