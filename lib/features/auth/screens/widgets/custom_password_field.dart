import 'package:flutter/material.dart';

import '../../../../theme/pallete.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  const CustomPasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _passwordVisible = false;
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
        obscureText: !_passwordVisible,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Pallete.greyColor,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          hintText: "Password",
          border: InputBorder.none,
        ),
        validator: ((value) {
          if (value == null || value.isEmpty) {
            return "Please enter your password";
          }
          return null;
        }),
      ),
    );
  }
}
