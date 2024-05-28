import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets.dart';

class ReusableTextFormField extends StatelessWidget {
  const ReusableTextFormField({super.key,
    this.label,
    this.hintText,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.borderColor,
    this.suffixIcon,
    this.controller,
    this.borderWidth = 1.6,
    this.enabled = true,
    this.inputFormatters,
    this.fontSize = 22,
  });

  final String? label;
  final String? hintText;
  final String? errorMessage;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color? borderColor;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final double borderWidth;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return ReusableBoxDecoration(
      child: SizedBox(
        height: size.height * 0.07,
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: fontSize),
          inputFormatters: inputFormatters,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            isDense: true, //Uses less space vertically
            label: label != null 
              ? Text(label!, style: TextStyle(color: Colors.black.withOpacity(0.65)),) 
              : null,
            labelStyle: const TextStyle(fontSize: 22),
            hintText: hintText,
            errorText: errorMessage,
            errorStyle: const TextStyle(fontSize: 16),
            focusColor: colors.primary,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon, 
          ),
        ),
      ),
    );
  }
}