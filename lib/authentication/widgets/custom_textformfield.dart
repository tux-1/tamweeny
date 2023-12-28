import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final void Function(String?)? onSaved;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final String? Function(String?)? validator;

  CustomTextField({
    this.onSaved,
    this.keyboardType = TextInputType.emailAddress,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xffDEA568),
            ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: 1,
        maxLength: maxLength,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontSize: 20,
            height: 0.1
          ),
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
