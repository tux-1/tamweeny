import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../authentication/provider/auth.dart';
import '../authentication/screens/logIn_screen.dart';
import '../generated/l10n.dart';

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
              ListTile(
                leading: const Icon(Icons.co_present_outlined),
                title: Text(S.of(context).account_information),
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: Text(S.of(context).order_history),
              ),
              ListTile(
                leading: const Icon(Icons.favorite_border),
                title: Text(S.of(context).favorite_products),
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
                trailing: Text('500'),
                //Numbers should be fetched from backend here
              ),
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
                  await ref.read(authProvider)
                      .logOut()
                      .then((value) {
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
