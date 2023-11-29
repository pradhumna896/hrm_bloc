import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      this.alignment,
      this.maxlength,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.hintStyle,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.filled = true,
      this.validator,
      this.readOnly = false,
      this.onTap,
      this.labelText,
      this.maxLength,
      this.inputFormatters,
      this.footerText,
      this.initialValue,
      this.onChanged})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final Function(String)? onChanged;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;
  final bool? obscureText;
  final bool readOnly;
  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;
  final int? maxlength;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final void Function()? onTap;

  final String? labelText;

  final int? maxLength;

  final List<TextInputFormatter>? inputFormatters;

  final FormFieldValidator<String>? validator;

  final String? footerText;

  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        margin: margin,
        child: Column(
          children: [
            Container(
              height: 44.h,
              child: TextFormField(
                maxLength: maxlength,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: onTap,
            
                controller: controller,
                initialValue: initialValue,
                // focusNode: focusNode ?? FocusNode(),
                inputFormatters: inputFormatters,
                onChanged: onChanged,
                autofocus: autofocus!,
                style: textStyle ??
                    TextStyle(
                      color: Colors.black87,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                obscureText: obscureText!,
                textInputAction: textInputAction,
                keyboardType: textInputType,
                maxLines: maxLines ?? 1,
                decoration: decoration,
                validator: validator,
                readOnly: readOnly,
              ),
            ),
          ],
        ),
      );
  InputDecoration get decoration => InputDecoration(
        labelText: labelText ?? "",
        hintText: hintText ?? "",
        hintStyle: hintStyle ??
            TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
        labelStyle: TextStyle(
          color: Colors.black87,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        counterStyle: const TextStyle(color: Colors.white),
        errorStyle: const TextStyle(color: Colors.red),
        contentPadding: contentPadding ?? EdgeInsets.all(21.h),
        fillColor: fillColor ?? Colors.white.withOpacity(0.85),
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: Colors.orange.withOpacity(0.25),
                width: 1,
              ),
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: Colors.orange.withOpacity(0.2),
                width: 1,
              ),
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: BorderSide(
                color: Colors.orange.withOpacity(0.2),
                width: 1,
              ),
            ),
        errorBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.h),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlinePrimary => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide(
          color: Colors.orange.withOpacity(0.25),
          width: 1,
        ),
      );
  static OutlineInputBorder get outlinePrimaryTL102 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.h),
        borderSide: BorderSide(
          color: Colors.orange.withOpacity(0.1),
          width: 1,
        ),
      );
}
