import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamweeny/features/authentication/screens/logIn_screen.dart';
import 'package:tamweeny/features/authentication/services/tamween_register.dart';

import '../../../generated/l10n.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_scaffold.dart';
import '../../../widgets/custom_textformfield.dart';

class TamweenSignUpScreen extends StatefulWidget {
  const TamweenSignUpScreen({super.key});
  static const routeName = "/tamween-signup";

  @override
  State<TamweenSignUpScreen> createState() => _TamweenSignUpScreenState();
}

class _TamweenSignUpScreenState extends State<TamweenSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _wageController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isLoading = false;
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

  final List<Uint8List> _dependentsImages = [];
  final List<Uint8List> _ownerImages = [];

  final List<List<int>> _uploadDependentsImages = [];
  final List<List<int>> _uploadOwnerImages = [];

  final Map<String, String> _signUpData = {
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
      if (img != null) {
        _dependentsImages.add(img);
        _uploadDependentsImages.add(img.toList());
      }
    });
  }

  void pickOwnerImages() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      if (img != null) {
        _ownerImages.add(img);
        _uploadOwnerImages.add(img.toList());
      }
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
                    if (picker.toString().contains('Owner')) {
                      _uploadOwnerImages.clear();
                    } else {
                      _uploadDependentsImages.clear();
                    }
                  });
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        Container(
            //images holder
            constraints:
                const BoxConstraints(minHeight: 50, minWidth: double.infinity),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white),
            ),
            child: SizedBox(
              height: 40,
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
            )),
      ],
    );
  }

  void showErrorDialog({String? message}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message ?? S.of(context).data_entry_error,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        );
      },
    );
  }

  Future<void> register(BuildContext context) async {
    final navigator = Navigator.of(context);
    if (chosenGender == null ||
        chosenMaritalStatus == null ||
        _ownerImages.isEmpty) {
      showErrorDialog();
      return;
    }
    if (_formKey.currentState?.validate() == false) {
      showErrorDialog();
    }
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      if (kDebugMode) {
        print("sign up date from widget: $_signUpData");
      }
      setState(() {
        isLoading = true;
      });
      // sign up function that'll send data to backend
      await registerToTamween(
        name: _nameController.text,
        gender: chosenGender.toString(),
        email: _emailController.text,
        socialStatus: chosenMaritalStatus.toString(),
        salary: num.parse(_wageController.text),
        phoneNumber: int.parse(_phoneNumberController.text),
        nationalIdCardAndBirthCertificate: _uploadOwnerImages,
        followersNationalIdCardsAndBirthCertificates: _uploadDependentsImages,
      ).then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Successful',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          },
        ).then((_) {
          navigator.popUntil(ModalRoute.withName(LogInScreen.routeName));
        }).onError((error, stackTrace) {
          setState(() {
            isLoading = false;
          });
          if (kDebugMode) {
            print(error);
          }
          showErrorDialog(message: 'An error occured');
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppBar(
                title: Text(
                  S.of(context).apply_for_tamween_card,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: const Color(0xffDEA568),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(S.of(context).name),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      controller: _nameController,
                      onSaved: (name) => _signUpData['name'] = name.toString(),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return S.of(context).please_fill_out_this_field;
                        }
                        return null;
                      },
                    ),
                    Text(S.of(context).gender),
                    DecoratedBox(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: const Color(0xffDEA568),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(S.of(context).email),
                    CustomTextField(
                      controller: _emailController,
                      onSaved: (email) =>
                          _signUpData['email'] = email.toString(),
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
                      controller: _phoneNumberController,
                      onSaved: (telephoneNumber) =>
                          _signUpData['telephoneNumber'] =
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

                    DecoratedBox(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
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
                      controller: _wageController,
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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    register(context);
                                  },
                            child: Text(S.of(context).register),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
