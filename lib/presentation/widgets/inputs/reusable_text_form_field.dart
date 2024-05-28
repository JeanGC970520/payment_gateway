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
    this.fontSize = 18,
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

    return ReusableBoxDecoration(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5,),
        child: TextFormField(
          enabled: enabled,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: fontSize),
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            isDense: true, //Uses less space vertically
            label: label != null 
              ? Text(label!, style: TextStyle(color: Colors.black.withOpacity(0.65)),) 
              : null,
            labelStyle: const TextStyle(fontSize: 20),
            hintText: hintText,
            errorText: errorMessage,
            errorStyle: const TextStyle(fontSize: 14),
            focusColor: colors.primary,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon, 
          ),
        ),
      ),
    );
  }
}