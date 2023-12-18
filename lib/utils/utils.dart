import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

const Map<int, Color> kColorMap = {
  50: Color.fromRGBO(51, 81, 69, .1),
  100: Color.fromRGBO(51, 81, 69, .2),
  200: Color.fromRGBO(51, 81, 69, .3),
  300: Color.fromRGBO(51, 81, 69, .4),
  400: Color.fromRGBO(51, 81, 69, .5),
  500: Color.fromRGBO(51, 81, 69, .6),
  600: Color.fromRGBO(51, 81, 69, .7),
  700: Color.fromRGBO(51, 81, 69, .8),
  800: Color.fromRGBO(51, 81, 69, .9),
  900: Color.fromRGBO(51, 81, 69, 1),
};

MaterialColor colorCustom = MaterialColor(0x335145, kColorMap);
