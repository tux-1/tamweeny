import 'package:flutter/material.dart';

import '../utils/lang.dart';

class TextFormFieldCard extends StatelessWidget {
  final IconData icon;
  final Function(String?) onSaved;
  final int? maxLength;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const TextFormFieldCard({
    super.key,
    required this.icon,
    required this.onSaved,
    this.readOnly = false,
    this.labelText,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.controller,
    this.validator,
    this.maxLength,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color.fromARGB(114, 255, 255, 255)),
        color: const Color(0xff335145),
      ),
      child: Row(
        children: [
          const Divider(
            indent: 20,
          ),
          Icon(icon),
          const Divider(
            indent: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Language.isArabic()
                      ? const Radius.circular(15)
                      : Radius.zero,
                  topRight: Language.isArabic()
                      ? Radius.zero
                      : const Radius.circular(15),
                  bottomLeft: Language.isArabic()
                      ? const Radius.circular(15)
                      : Radius.zero,
                  bottomRight: Language.isArabic()
                      ? Radius.zero
                      : const Radius.circular(15),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
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
                controller: controller,
                validator: validator,
                readOnly: readOnly,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: null,
                  hintText: ' $labelText',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: const Color(0xffD99D63)),
                  focusColor: Colors.white,
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
