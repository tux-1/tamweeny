import 'package:flutter/material.dart';

import '../../../utils/lang.dart';

class TextFormFieldCard extends StatelessWidget {
  final IconData icon;
  final Function(String?)? onSaved;
  final int? maxLength;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  TextFormFieldCard({
    super.key,
    required this.icon,
    this.onSaved,
    this.readOnly = false,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.controller,
    this.validator,
    this.maxLength,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
  });

  final _borderRadius1 = BorderRadius.only(
    topLeft: !Language.isArabic() ? const Radius.circular(15) : Radius.zero,
    topRight: !Language.isArabic() ? Radius.zero : const Radius.circular(15),
    bottomLeft: !Language.isArabic() ? const Radius.circular(15) : Radius.zero,
    bottomRight: !Language.isArabic() ? Radius.zero : const Radius.circular(15),
  );

  final _borderRadius2 = BorderRadius.only(
    topLeft: Language.isArabic() ? const Radius.circular(15) : Radius.zero,
    topRight: Language.isArabic() ? Radius.zero : const Radius.circular(15),
    bottomLeft: Language.isArabic() ? const Radius.circular(15) : Radius.zero,
    bottomRight: Language.isArabic() ? Radius.zero : const Radius.circular(15),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      constraints: const BoxConstraints(maxHeight: 60),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color.fromARGB(114, 255, 255, 255)),
          color: const Color.fromARGB(4, 255, 255, 255)),
      child: Row(
        children: [
          SizedBox(
            height: double.maxFinite,
            width: 55,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: _borderRadius1,
                color: const Color.fromARGB(255, 51, 81, 69),
              ),
              child: Icon(icon),
            ),
          ),
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              maxLength: maxLength,
              cursorColor: Colors.white,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              onSaved: onSaved,
              obscureText: obscureText,
              onTap: onTap,
              onChanged: onChanged,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: controller,
              validator: validator,
              readOnly: readOnly,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 10),
                errorBorder: OutlineInputBorder(
                    borderRadius: _borderRadius2,
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.error)),
                isDense: true,
                errorMaxLines: 1,
                errorStyle: const TextStyle(
                  fontSize: 0,
                ),
                suffixIcon: suffixIcon,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: null,
                counterText: "",
                hintText: '$labelText',
                hintStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: const Color(0xffD99D63)),
                focusColor: Colors.white,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
