import 'package:flutter/material.dart';

import '../../utils/lang.dart';

class TextFormFieldCard extends StatefulWidget {
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
  State<TextFormFieldCard> createState() => _TextFormFieldCardState();
}

class _TextFormFieldCardState extends State<TextFormFieldCard> {
  late bool obscureText;
  bool showIcon = false;

  @override
  void initState() {
    obscureText = widget.obscureText;
    super.initState();
  }

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
                borderRadius: BorderRadius.only(
                  topLeft: !Language.isArabic()
                      ? const Radius.circular(15)
                      : Radius.zero,
                  topRight: !Language.isArabic()
                      ? Radius.zero
                      : const Radius.circular(15),
                  bottomLeft: !Language.isArabic()
                      ? const Radius.circular(15)
                      : Radius.zero,
                  bottomRight: !Language.isArabic()
                      ? Radius.zero
                      : const Radius.circular(15),
                ),
                color: const Color.fromARGB(255, 51, 81, 69),
              ),
              child: Icon(widget.icon),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                maxLength: widget.maxLength,
                cursorColor: Colors.white,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                onSaved: widget.onSaved,
                obscureText: obscureText,
                onTap: () {
                  widget.onTap;
                  setState(() {
                    showIcon = true;
                  });
                },
                onChanged: (_){
                  setState(() {
                    showIcon = true;
                  });
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    showIcon = false;
                  });
                },
                controller: widget.controller,
                validator: widget.validator,
                readOnly: widget.readOnly,
                decoration: InputDecoration(
                  suffixIcon: widget.obscureText && showIcon
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                ))
                      : null,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  enabledBorder: null,
                  hintText: ' ${widget.labelText}',
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
