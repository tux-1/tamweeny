import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:tamweeny/generated/l10n.dart';

import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/custom_textformfield.dart';
import '../../navigation_screen.dart';
import '../providers/account_info.dart';
import '../providers/account_updater.dart';

class EditAccountScreen extends ConsumerStatefulWidget {
  const EditAccountScreen({super.key});
  static const routeName = '/edit-account';

  @override
  ConsumerState<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends ConsumerState<EditAccountScreen> {
  late TextEditingController nameController;
  late TextEditingController telephoneNumberController;
  late TextEditingController birthDateController;
  late TextEditingController addressController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final userData = ref.read(accountInfoProvider).value;
    nameController = TextEditingController(text: userData?['name']);
    telephoneNumberController =
        TextEditingController(text: userData?['phoneNumber'].toString());
    birthDateController =
        TextEditingController(text: userData?['birthDate'].toString());
    addressController =
        TextEditingController(text: userData?['street'].toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    telephoneNumberController.dispose();
    birthDateController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          S.of(context).account_information,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                Text(S.of(context).name),
                CustomTextField(
                  controller: nameController,
                  validator: ValidationBuilder().maxLength(12).build(),
                ),

                //
                Text(S.of(context).telephone_number),
                CustomTextField(
                  controller: telephoneNumberController,
                  validator: ValidationBuilder().maxLength(11).build(),
                ),

                //
                Text(S.of(context).birth_date),
                CustomTextField(
                  controller: birthDateController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());
                    if (pickedDate != null) {
                      birthDateController.text =
                          DateFormat('yyyy-MM-dd', 'en').format(pickedDate);
                    }
                  },
                ),

                //
                Text(S.of(context).address),
                CustomTextField(
                  controller: addressController,
                  validator: ValidationBuilder().maxLength(50).build(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 25,
              top: 12,
            ),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      final nav = Navigator.of(context);
                      setState(() {
                        isLoading = true;
                      });
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Dialog(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              heightFactor: 2,
                              widthFactor: 2,
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ),
                      );

                      await updateAccountInfo(
                        name: nameController.text,
                        phoneNumber: telephoneNumberController.text,
                        birthDate: birthDateController.text,
                        street: addressController.text,
                      ).then((value) async {
                        ref.invalidate(accountInfoProvider);
                        nav.popUntil(
                            ModalRoute.withName(NavigationScreen.routeName));
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('An error occured')));
                      });
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
              child: Text(S.of(context).confirm),
            ),
          )
        ],
      ),
    );
  }
}
