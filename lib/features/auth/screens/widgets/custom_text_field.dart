import 'package:flutter/material.dart';

import '../../../../theme/pallete.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.90,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: Pallete.grayColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}