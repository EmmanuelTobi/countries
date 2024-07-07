import 'package:countries/utils/colors.dart';
import 'package:flutter/material.dart';

mixin BoxDecorators {

  static BoxDecoration containerDecoration({
    Color? color,
    double? radius,
    Color? outlineColor,
    bool? hasShadow = false,
    double? outlineWidth,
    bool? hasOutline = false}) => BoxDecoration(
    color: color,
    border: hasOutline! ? Border.all(
      color: outlineColor ?? XColors.primaryColor(),
      width: outlineWidth ?? 1,
    ) : null,
    borderRadius: BorderRadius.all(Radius.circular(radius ?? 18.0)),
    boxShadow: hasShadow! ? [BoxShadow(color: Colors.black12.withOpacity(0.05), blurRadius: 19, spreadRadius: 2)] : null,
  );

  static BoxDecoration containerTopRoundedDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 5)
    ],
  );

  static BoxDecoration outlineContainerDecoration({Color? color, int? width, double? radius}) =>
      BoxDecoration(
          borderRadius: BorderRadius.circular( radius ?? 11),
          border: Border.all(
              color: color ?? XColors.primaryColor(),
              width: width != null ? width as double : 1,
          )
      );
}