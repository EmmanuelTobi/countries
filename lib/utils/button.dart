import 'package:countries/utils/colors.dart';
import 'package:countries/utils/text.dart';
import 'package:flutter/material.dart';

class XButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Function? onPressed;
  final String? text;
  final double? radius;
  final Color? buttonColor;
  final Color? textColor;
  final bool isLoading;
  final Color? progressColor;
  final double? textSize;
  final FontWeight? fontWeight;
  final bool isOutline;
  final Color? borderColor;
  final bool hasShadow;
  final bool? isComing;
  final Widget? buttonWidget;

  XButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.height,
    this.width,
    this.radius,
    this.buttonColor,
    this.textColor,
    this.isLoading = false,
    this.progressColor,
    this.textSize,
    this.hasShadow = false,
    this.fontWeight,
    this.isOutline = false,
    this.borderColor,
    this.isComing = false,
    this.buttonWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isOutline) {
      return TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              buttonColor ?? XColors.background()),
          elevation: MaterialStateProperty.all(0),
          minimumSize:
              MaterialStateProperty.all(Size(width ?? 300, height ?? 56)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 28),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonWidget != null) ...[
              buttonWidget!
            ] else ...[
              NormalText(
                text: text ?? 'Continue',
                textColor: textColor ?? XColors.white(),
                fontWeight: FontWeight.w400,
                fontSize: textSize ?? 15,
              ),
            ],
          ],
        ),
        onPressed: () => onPressed!(),
      );
    } else {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width ?? 300, height ?? 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 28),
            side: BorderSide(color: XColors.primaryColor(), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonWidget != null) ...[
              buttonWidget!
            ] else ...[
              NormalText(
                text: text ?? 'Continue',
                textColor: textColor ?? XColors.white(),
                fontWeight: FontWeight.w400,
                fontSize: textSize ?? 15,
              ),
            ],
          ],
        ),
        onPressed: () => onPressed!(),
      );
    }
  }
}
