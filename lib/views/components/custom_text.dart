import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {required this.text,
      this.color,
      this.backgroundColor,
      this.fontSize,
      this.fontWeight,
      this.fontStyle,
      this.letterSpacing,
      this.wordSpacing,
      this.textBaseline,
      this.height,
      this.fontFamily,
      this.textAlign,
      this.textDirection,
      this.overflow,
      this.maxLines,
      Key? key})
      : super(key: key);

  final String text;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
          fontStyle: fontStyle,
          backgroundColor: backgroundColor,
          overflow: overflow,
          letterSpacing: letterSpacing,
          height: height),
    );
  }
}
