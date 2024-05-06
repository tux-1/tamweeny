import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/widgets/custom_textformfield.dart';

import '../../../../generated/l10n.dart';
import '../../../../widgets/custom_scaffold.dart';
import '../../../../providers/auth.dart';
import '../../../authentication/screens/logIn_screen.dart';
import '../providers/account_info.dart';
import 'edit_account_screen.dart';

class AccountInfoScreen extends ConsumerWidget {
  const AccountInfoScreen({super.key});
  static const routeName = 'account-information';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(accountInfoProvider.future);
    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).account_information,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: FutureBuilder(
        future: userData,
        builder: (context, userDataSnapshot) {
          if (userDataSnapshot.data != null) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditAccountScreen.routeName);
                  },
                  icon: const Icon(Icons.edit),
                  label: Text(S.of(context).edit),
                ),

                // Name
                Text(S.of(context).name),
                CustomTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: userDataSnapshot.data?['name'],
                  ),
                ),
                const SizedBox(height: 7),

                // Email
                Text(S.of(context).email),
                CustomTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: userDataSnapshot.data?['email'],
                  ),
                ),
                const SizedBox(height: 7),

                // National number
                Text(S.of(context).national_number),
                CustomTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: userDataSnapshot.data?['nationalId'].toString(),
                  ),
                ),
                const SizedBox(height: 7),

                // Telephone number
                Text(S.of(context).telephone_number),
                CustomTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: userDataSnapshot.data?['phoneNumber'].toString(),
                  ),
                ),
                const SizedBox(height: 7),

                // Birth date
                Text(S.of(context).birth_date),
                CustomTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: userDataSnapshot.data?['birthDate'].toString(),
                  ),
                ),
                const SizedBox(height: 7),

                // Address
                Text(S.of(context).address),
                CustomTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: userDataSnapshot.data?['street'].toString(),
                  ),
                ),
                const SizedBox(height: 7),

                // Tamween card number
                Text(S.of(context).tamween_card_number),
                CustomTextField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: userDataSnapshot.data?['cardNumber'].toString(),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25, top: 12),
                  child: ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(S.of(context).confirm_delete_account),
                            content:
                                Text(S.of(context).action_cannot_be_undone),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(S.of(context).no),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final nav = Navigator.of(context);

                                  await ref
                                      .read(authProvider)
                                      .deleteAccount()
                                      .then((value) {
                                    return nav.pushReplacementNamed(
                                        LogInScreen.routeName);
                                  });
                                },
                                child: Text(S.of(context).yes),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(S.of(context).delete_account),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text('Error occured'),
            );
          }
        },
      ),
    );
  }
}
