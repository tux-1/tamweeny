import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_scaffold.dart';
import '../widgets/custom_textformfield.dart';

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
  String? chosenGender;

  List<String> maritalStatus = [
    'Single',
    'Married',
    'Divorced',
  ];
  String? chosenMaritalStatus;
  // ignore: prefer_final_fields
  List<Uint8List> _dependentsImages = [];
  // ignore: prefer_final_fields
  List<Uint8List> _ownerImages = [];
// ignore: prefer_final_fields
  Map<String, String> _signUpData = {
    'name': '',
    'gender': '',
    'email': '',
    'telephoneNumber': '',
    'maritalStatus': '',
    'minimumSalary': '',
  };

  void pickDependentsImages() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img != null) _dependentsImages.add(img);
    });
  }

  void pickOwnerImages() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img != null) _ownerImages.add(img);
    });
  }

  Widget imagesPicker(
    String title,
    List<Uint8List> imagesList,
    Function() picker,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Text(title),
            IconButton(onPressed: picker, icon: const Icon(Icons.add)),
            const Spacer(),
            IconButton(
                onPressed: () {
                  setState(() {
                    imagesList.clear();
                  });
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        Container(
          constraints:
              const BoxConstraints(minHeight: 50, minWidth: double.infinity),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white),
          ),
          child: imagesList.isNotEmpty
              ? SizedBox(
                  height: 35,
                  child: ListView.builder(
                      padding: const EdgeInsets.all(1),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: imagesList.length,
                      itemBuilder: (ctx, i) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(imagesList[i]),
                          ),
                        );
                      }),
                )
              : null,
        ),
      ],
    );
  }

  Future<void> register(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (chosenGender == null ||
        chosenMaritalStatus == null ||
        _ownerImages.isEmpty) {
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
      return;
    }
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
      _formKey.currentState?.save();
      // print(_signUpData);
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
        navigator.pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: deviceSize.height*0.05),
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
                  onSaved: (name) => _signUpData['name'] = name.toString(),
                  validator: (name) {
                    if (name!.isEmpty) {
                      return S.of(context).please_fill_out_this_field;
                    }
                    return null;
                  },
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
                        groupValue: chosenGender,
                        onChanged: (value) => setState(() {
                          chosenGender = value.toString();
                          _signUpData['gender'] = chosenGender.toString();
                        }),
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
                        groupValue: chosenGender,
                        onChanged: (value) => setState(() {
                          chosenGender = value.toString();
                          _signUpData['gender'] = chosenGender.toString();
                        }),
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
                  onSaved: (email) => _signUpData['email'] = email.toString(),
                  validator: (emailText) {
                    if (emailText!.isEmpty) {
                      return S.of(context).please_fill_out_this_field;
                    }
                    return null;
                  },
                ),
                Text(S.of(context).telephone_number),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  onSaved: (telephoneNumber) => _signUpData['telephoneNumber'] =
                      telephoneNumber.toString(),
                  validator: (telephoneNumber) {
                    if (int.tryParse(telephoneNumber.toString()) == null &&
                        telephoneNumber!.isNotEmpty) {
                      return S.of(context).please_enter_valid_number;
                    }
                    if (telephoneNumber!.isEmpty) {
                      return S.of(context).please_fill_out_this_field;
                    }
                    return null;
                  },
                ),
                Text(S.of(context).marital_status),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      RadioMenuButton(
                        value: maritalStatus[0],
                        groupValue: chosenMaritalStatus,
                        onChanged: (value) => setState(() {
                          chosenMaritalStatus = value.toString();
                          _signUpData['maritalStatus'] =
                              chosenMaritalStatus.toString();
                        }),
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
                        groupValue: chosenMaritalStatus,
                        onChanged: (value) {
                          setState(() {
                            chosenMaritalStatus = value.toString();
                            _signUpData['maritalStatus'] =
                                chosenMaritalStatus.toString();
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
                        groupValue: chosenMaritalStatus,
                        onChanged: (value) {
                          setState(() {
                            chosenMaritalStatus = value.toString();
                            _signUpData['maritalStatus'] =
                                chosenMaritalStatus.toString();
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
                  onSaved: (minimumSalary) {
                    _signUpData['minimumSalary'] = minimumSalary.toString();
                  },
                  validator: (minimumSalary) {
                    if (double.tryParse(minimumSalary.toString()) == null &&
                        minimumSalary!.isNotEmpty) {
                      return S.of(context).please_enter_valid_number;
                    }
                    if (minimumSalary!.isEmpty) {
                      return S.of(context).please_fill_out_this_field;
                    }
                    return null;
                  },
                ),
                //Owner Images Picker
                imagesPicker(
                  S.of(context).id_and_birth_certificate,
                  _ownerImages,
                  pickOwnerImages,
                ),
                //Dependents Images Picker
                imagesPicker(
                  S.of(context).dependents_id_and_birth_certificate,
                  _dependentsImages,
                  pickDependentsImages,
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
