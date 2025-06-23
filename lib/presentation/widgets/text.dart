import 'package:flutter/material.dart';

// Text Style Types Enum
enum TextKind {
  heading,
  body,
  caption,
  primary,
  error,
  doToFamily,
  doToRoundedFamily,
}

// Text Style Constants
class AppTextStyles {
  static TextStyle heading(BuildContext context) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'Sansation',
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    fontFamily: 'Sansation',
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Sansation',
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
  );

  static TextStyle primary(BuildContext context) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Sansation',
    color: Theme.of(context).colorScheme.primary,
  );

  static TextStyle error(BuildContext context) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: 'Sansation',
    color: Theme.of(context).colorScheme.error,
  );

  // New: Doto Regular Font Style
  static TextStyle doToFamily(BuildContext context) => TextStyle(
    fontFamily: 'Doto',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface,
  );

  // New: Doto Rounded Font Style
  static TextStyle doToRoundedFamily(BuildContext context) => TextStyle(
    fontFamily: 'DotoRounded',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurface,
  );

  // Get style by kind
  static TextStyle getStyle(BuildContext context, TextKind kind) {
    switch (kind) {
      case TextKind.heading:
        return heading(context);
      case TextKind.body:
        return body(context);
      case TextKind.caption:
        return caption(context);
      case TextKind.primary:
        return primary(context);
      case TextKind.error:
        return error(context);
      case TextKind.doToFamily:
        return doToFamily(context);
      case TextKind.doToRoundedFamily:
        return doToRoundedFamily(context);
    }
  }
}

// Single Text Widget
class AppText extends StatelessWidget {
  final String text;
  final TextKind kind;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool showErrorIcon;

  const AppText(
    this.text, {
    super.key,
    this.kind = TextKind.body,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.showErrorIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = AppTextStyles.getStyle(context, kind);
    final finalStyle = baseStyle.copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
