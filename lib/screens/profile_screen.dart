import 'package:flutter/material.dart';
import '../authentication/screens/logIn_screen.dart';
import '../generated/l10n.dart';

import '../widgets/custom_scaffold.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile-screen';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      
      body: ListView(
        physics: const ScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: CircleAvatar(
                  minRadius: 40,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 50,
                  ),
                ),
              ),
              Text('Customer Name'),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
          //the ListTiles are inside a 0 elevation Card to prevent the
          // BackdropFilter from filtering the ListTile ontap ripple.
          Card(
            elevation: 0,
            color: Colors.transparent,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.co_present_outlined),
                  title: Text(S.of(context).account_information),
                ),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(S.of(context).order_history),
                ),
                ListTile(
                  leading: const Icon(Icons.local_offer),
                  title: Text(S.of(context).offers),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(S.of(context).notifications),
                ),
                ListTile(
                  leading: const Icon(Icons.wallet),
                  title: Text(S.of(context).wallet_balance),
                ),
                ListTile(
                  leading: const Icon(Icons.credit_score),
                  title: Text(S.of(context).current_month_balance),
                  trailing:
                      Text('500'), //Numbers should be fetched from backend here
                ),
                ListTile(
                  leading: const Icon(Icons.credit_score),
                  title: Text(S.of(context).previous_month_balance),
                  trailing:
                      Text('500'), //Numbers should be fetched from backend here
                ),
                ListTile(
                  leading: const Icon(Icons.question_mark_rounded),
                  title: Text(S.of(context).get_help),
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(S.of(context).about_the_app),
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(S.of(context).sign_out),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LogInScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
