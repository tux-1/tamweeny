import 'package:flutter/material.dart';

import 'package:tamweeny/features/user/profile/widgets/log_out_listtile.dart';
import 'package:tamweeny/features/user/profile/widgets/username_widget.dart';

import '../../../generated/l10n.dart';

import 'screens/account_information_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/orders_history.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      physics: const ScrollPhysics(),
      children: [
        const UsernameWidget(),
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            children: [
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
                    builder: (context) => const OrdersHistoryScreen(),
                  ));
                },
              ),

              // Favorite products
              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: Text(S.of(context).favorite_products),
                onTap: () {
                  Navigator.of(context).pushNamed(FavoritesScreen.routeName);
                },
              ),

              // Notifs
              ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(S.of(context).notifications),
              ),

              // Wallet ??
              ListTile(
                leading: const Icon(Icons.wallet),
                title: Text(S.of(context).wallet_balance),
              ),

              // Current balance
              ListTile(
                leading: const Icon(Icons.credit_score),
                title: Text(S.of(context).current_month_balance),
                trailing: const Text('500'),
                //Numbers should be fetched from backend here
              ),

              // Previous month balance
              ListTile(
                leading: const Icon(Icons.credit_score),
                title: Text(S.of(context).previous_month_balance),
                trailing: const Text('500'),
                //Numbers should be fetched from backend here
              ),
              ListTile(
                leading: const Icon(Icons.question_mark_rounded),
                title: Text(S.of(context).get_help),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(S.of(context).about_the_app),
              ),
              const LogOutListTile(),
            ],
          ),
        ),
      ],
    );
  }
}
