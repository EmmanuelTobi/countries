import 'package:countries/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainInputField extends StatelessWidget {
  MainInputField({
        super.key,
        this.controller,
        this.label,
        this.currentNode,
        this.hint,
        this.nextNode,
        this.isPassword = false,
        this.autoValidate = false,
        this.errorText = '',
        this.onChanged,
        this.validator,
        this.borderColor,
        this.onsaved,
        this.keyboard,
        this.initialValue,
        this.copy = false,
        this.isEnabled = true,
        this.onFieldSubmitted,
        this.textInputAction,
        this.maxLines = 1,
        this.showHint = true,
        this.isForgottenOption = false,
        this.suffixIcon,
        this.inputFormatters}
      );

  final String? label;
  final String? hint;
  final FocusNode? currentNode;
  final FocusNode? nextNode;
  final String? errorText;
  final bool isPassword;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onsaved;
  final TextInputType? keyboard;
  final bool isEnabled;
  final bool copy;
  final bool autoValidate;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final dynamic onFieldSubmitted;
  final int maxLines;
  final bool showHint;
  final TextEditingController? controller;
  final bool isForgottenOption;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final Widget? suffixIcon;

  final ValueNotifier<bool> hasError = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          textAlign: TextAlign.center,
          enabled: isEnabled,
          initialValue: initialValue,
          keyboardType: keyboard,
          obscureText: isPassword,
          onChanged: onChanged,
          validator: (s) {
            if(validator != null) {
              return validator!(s);
            } else {
              hasError.value = false;
              return null;
            }
          },
          focusNode: currentNode,
          inputFormatters: inputFormatters,
          onSaved: (String? value) {
            FocusScope.of(context).requestFocus(nextNode);
            onsaved!(value);
          },
          onFieldSubmitted: (String? value) {
            FocusScope.of(context).requestFocus(nextNode);
            if(onFieldSubmitted != null) {
              onFieldSubmitted(value);
            }
          },
          textInputAction: textInputAction,
          decoration: InputDecoration(
            fillColor: XColors.primaryColor().withOpacity(0.0),
            filled: true,
            hintStyle: const TextStyle(color: Colors.grey),
            hintText: hint,
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(
                  color: XColors.primaryColor().withOpacity(0.1),
                  width: 1
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(11.0)),
              borderSide: BorderSide(
                  color: XColors.primaryColor().withOpacity(0.1),
                  width: 1
              ),
            ),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(11.0)),
                borderSide: BorderSide(color: Colors.red)
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                borderSide: BorderSide(
                    color: Colors.red,
                    width: 2
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(
                    color: XColors.primaryColor(),
                    width: 2
                )
            ),
            contentPadding: const EdgeInsets.only(bottom: 17, left: 10.0, right: 10.0, top: 17),
            labelText: label,
            labelStyle: TextStyle(color: XColors.textColor(), fontWeight: FontWeight.w400),
          ),
          style: TextStyle(color: XColors.textColor(), fontWeight: FontWeight.w400, fontSize: 16),
        ),
        if(suffixIcon != null) ... [
          Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: suffixIcon!
          )
        ]
      ],
    );
  }
}