import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  const NormalText(
      {super.key, required this.text,
        this.fontSize,
        this.textColor,
        this.fontWeight,
        this.textAlign,
        this.maxLines
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: fontSize ?? 15,
          color: textColor ?? Colors.black,
          fontWeight: fontWeight ?? FontWeight.w400),
    );
  }
}