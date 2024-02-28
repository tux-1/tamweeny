import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamweeny/features/authentication/widgets/custom_textformfield.dart';

import '../../../generated/l10n.dart';
import '../../../widgets/custom_scaffold.dart';
import '../providers/account_info_provider.dart';

class AccountInformationScreen extends ConsumerWidget {
  const AccountInformationScreen({super.key});
  static const routeName = 'account-information';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(accountInfoProvider.future);

    return CustomScaffold(
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
          if (userDataSnapshot.hasData) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: Text(S.of(context).edit),
                ),

                // Name
                Text(S.of(context).name),
                CustomTextField(
                  readOnly: true,
                  initialValue: userDataSnapshot.data?['name'],
                ),
                const SizedBox(height: 7),

                // Email
                Text(S.of(context).email),
                CustomTextField(
                  readOnly: true,
                  initialValue: userDataSnapshot.data?['email'],
                ),
                const SizedBox(height: 7),

                // National number
                Text(S.of(context).national_number),
                CustomTextField(
                  readOnly: true,
                  initialValue: userDataSnapshot.data?['nationalId'].toString(),
                ),
                const SizedBox(height: 7),

                // Telephone number
                Text(S.of(context).telephone_number),
                CustomTextField(
                  readOnly: true,
                  initialValue:
                      userDataSnapshot.data?['phoneNumber'].toString(),
                ),
                const SizedBox(height: 7),

                // Birth date
                Text(S.of(context).birth_date),
                CustomTextField(
                  readOnly: true,
                  initialValue: userDataSnapshot.data?['birthDate'].toString(),
                ),
                const SizedBox(height: 7),

                // Address
                Text(S.of(context).address),
                CustomTextField(
                  readOnly: true,
                  initialValue: userDataSnapshot.data?['street'].toString(),
                ),
                const SizedBox(height: 7),

                // Tamween card number
                Text(S.of(context).tamween_card_number),
                CustomTextField(
                  readOnly: true,
                  initialValue: userDataSnapshot.data?['cardNumber'].toString(),
                ),
                const SizedBox(height: 7),
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
