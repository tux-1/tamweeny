import 'package:flutter/material.dart';
import 'package:tamweeny/features/driver/driver_profile/screens/delivered_orders_screen.dart';
import 'package:tamweeny/features/user/profile/widgets/log_out_listtile.dart';
import 'package:tamweeny/features/user/profile/widgets/username_widget.dart';

import '../../../generated/l10n.dart';
import '../../user/profile/screens/account_information_screen.dart';
import '../../user/profile/widgets/locale_switch_tile.dart';

class DriverProfilePage extends StatelessWidget {
  const DriverProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      children: [
        const UsernameWidget(),
        const SizedBox(height: 10),

        // Account information
        ListTile(
          leading: const Icon(Icons.co_present_outlined),
          title: Text(S.of(context).account_information),
          onTap: () {
            Navigator.of(context).pushNamed(AccountInfoScreen.routeName);
          },
        ),
        // Order history
        ListTile(
          leading: const Icon(Icons.history),
          title: Text(S.of(context).order_history),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const DeliveredOrdersScreen(),
            ));
          },
        ),
        const LocaleSwitchTile(),
        const LogOutListTile()
      ],
    );
  }
}
