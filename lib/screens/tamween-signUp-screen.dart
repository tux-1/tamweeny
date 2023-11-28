import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../generated/l10n.dart';
import '../helpers/utils.dart';
import '../widgets/custom_scaffold.dart';

class TamweenSignUpScreen extends StatefulWidget {
  const TamweenSignUpScreen({super.key});
  static const routeName = "/tamween-signup";

  @override
  State<TamweenSignUpScreen> createState() => _TamweenSignUpScreenState();
}

class _TamweenSignUpScreenState extends State<TamweenSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<String> genders = [
    'Male',
    'Female',
  ];
  String? genderOption;

  List<String> maritalStatus = [
    'Single',
    'Married',
    'Divorced',
  ];
  String? maritalStatusOption;
  List<Uint8List> _depsImages = [];
  List<Uint8List> _ownerImages = [];

  void selectDepsImages() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img != null) _depsImages.add(img);
    });
  }

  void selectOwnerImages() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img != null) _ownerImages.add(img);
    });
  }

  Future<void> register(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (_formKey.currentState?.validate() == false) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                S.of(context).data_entry_error,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          });
    }
    if (_formKey.currentState?.validate() == true) {
      // print(_password.text);
      // sign up function that'll send data to backend
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Successful',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          }).then((_) {
        navigator.pop();
        // navigator.pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    S.of(context).apply_for_tamween_card,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: const Color(0xffDEA568),
                        ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(S.of(context).name),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  // onSaved: ,
                ),
                Text(S.of(context).gender),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Wrap(
                    children: [
                      RadioMenuButton(
                        value: genders[0],
                        groupValue: genderOption,
                        onChanged: (value) {
                          setState(() {
                            genderOption = value.toString();
                          });
                        },
                        child: Text(
                          S.of(context).male,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xffDEA568),
                                  ),
                        ),
                      ),
                      RadioMenuButton(
                        value: genders[1],
                        groupValue: genderOption,
                        onChanged: (value) {
                          setState(() {
                            genderOption = value.toString();
                          });
                        },
                        child: Text(
                          S.of(context).female,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xffDEA568),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(S.of(context).email),
                CustomTextField(
                    // onSaved: ,
                    ),
                Text(S.of(context).telephone_number),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  // onSaved: ,
                ),
                Text(S.of(context).marital_status),
                Container(
                  // constraints: const BoxConstraints(maxHeight: 70),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RadioMenuButton(
                        value: maritalStatus[0],
                        groupValue: maritalStatusOption,
                        onChanged: (value) {
                          setState(() {
                            maritalStatusOption = value.toString();
                          });
                        },
                        child: Text(
                          S.of(context).single,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xffDEA568),
                                  ),
                        ),
                      ),
                      RadioMenuButton(
                        value: maritalStatus[1],
                        groupValue: maritalStatusOption,
                        onChanged: (value) {
                          setState(() {
                            maritalStatusOption = value.toString();
                          });
                        },
                        child: Text(
                          S.of(context).married,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xffDEA568),
                                  ),
                        ),
                      ),
                      RadioMenuButton(
                        value: maritalStatus[2],
                        groupValue: maritalStatusOption,
                        onChanged: (value) {
                          setState(() {
                            maritalStatusOption = value.toString();
                          });
                        },
                        child: Text(
                          S.of(context).divorced,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xffDEA568),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(S.of(context).minimum_salary),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  // onSaved: ,
                ),
                Row(
                  children: [
                    Text(S.of(context).id_and_birth_certificate),
                    IconButton(
                        onPressed: selectOwnerImages,
                        icon: const Icon(Icons.add)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _ownerImages.clear();
                          });
                        },
                        icon: const Icon(Icons.delete))
                  ],
                ),
                Container(
                  constraints: const BoxConstraints(
                      minHeight: 50, minWidth: double.infinity),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: _ownerImages.isNotEmpty
                      ? SizedBox(
                          height: 35,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(1),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _ownerImages.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(_ownerImages[i]),
                                  ),
                                );
                              }),
                        )
                      : null,
                ),
                Row(
                  children: [
                    Text(S.of(context).dependents_id_and_birth_certificate),
                    IconButton(
                        onPressed: selectDepsImages,
                        icon: const Icon(Icons.add)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _depsImages.clear();
                          });
                        },
                        icon: const Icon(Icons.delete))
                  ],
                ),
                Container(
                  constraints: const BoxConstraints(
                      minHeight: 50, minWidth: double.infinity),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: _depsImages.isNotEmpty
                      ? SizedBox(
                          height: 35,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(1),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: _depsImages.length,
                              itemBuilder: (ctx, i) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(_depsImages[i]),
                                  ),
                                );
                              }),
                        )
                      : null,
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      register(context);
                    },
                    child: Text(S.of(context).register),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final int? maxLength;

  CustomTextField({
    this.onSaved,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xffDEA568),
            ),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: 1,
        maxLength: maxLength,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          counterText: "",
          constraints: const BoxConstraints(maxHeight: 70),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
        ),
      ),
    );
  }
}
