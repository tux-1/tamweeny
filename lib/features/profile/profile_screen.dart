import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../authentication/provider/auth.dart';
import '../authentication/screens/logIn_screen.dart';
import '../../generated/l10n.dart';
import 'screens/account_information_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void logOut() async {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      physics: const ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
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
              const SizedBox(width: 5),
              Text('Customer Name'),
              Spacer(),
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
        ),
        Card(
          elevation: 0,
          color: Colors.transparent,
          child: Column(
            children: [
              // Account information
              ListTile(
                leading: const Icon(Icons.co_present_outlined),
                title: Text(S.of(context).account_information),
                onTap: () async {
                  final response2 = await http
                      .get(Uri.parse('http://10.0.2.2:8000/api/favorites'));
                  print(response2.body);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AccountInformationScreen(),
                  ));
                },
              ),

              // Order history
              ListTile(
                leading: const Icon(Icons.history),
                title: Text(S.of(context).order_history),
              ),

              // Favorite products
              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: Text(S.of(context).favorite_products),
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
                trailing: Text('500'),
                //Numbers should be fetched from backend here
              ),

              // Previous month balance
              ListTile(
                leading: const Icon(Icons.credit_score),
                title: Text(S.of(context).previous_month_balance),
                trailing: Text('500'),
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
              ListTile(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
