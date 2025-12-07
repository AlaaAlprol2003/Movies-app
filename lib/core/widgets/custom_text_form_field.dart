import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/resources/colors_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.preIcon,
    this.sufIcon,
    this.controller,
    this.isObscure = false,
    this.validator,
    this.keyboardType = TextInputType.text
  });
  final String hintText;
  final Widget? preIcon;
  final Widget? sufIcon;
  final TextEditingController? controller;
  final bool isObscure;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.roboto(fontSize: 16.sp,fontWeight: FontWeight.w500,color: ColorsManager.white),
      validator: validator,
      controller: controller,
      obscureText: isObscure,
      cursorColor: ColorsManager.white,
      keyboardType:keyboardType ,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
        border: InputBorder.none,
      ),
    );
  }
}
