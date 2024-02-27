import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constant/Colors/colors.dart';

class BuildTextFormField extends StatelessWidget {
  late TextEditingController controller;
  late String hintText;
  late IconData prefixIcon;
  Widget? suffixIcon;
  String? Function(String?)? valid;
  TextInputType? keyboardType;
  bool? isPassword;

  BuildTextFormField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    IconButton? this.suffixIcon,
    required String? Function(String?)? this.valid,
    TextInputType? this.keyboardType,
    bool? this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: GoogleFonts.openSans(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      validator: valid,
      keyboardType: keyboardType,
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
        errorStyle: GoogleFonts.lato(fontWeight: FontWeight.bold),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Icon(
            prefixIcon,
            color: MyColor.primaryColor,
          ),
        ),
        hintStyle: GoogleFonts.openSans(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

