import 'package:flutter/material.dart';
import 'package:sales_data_dashboard/Utils/app_sizer.dart';

class LoginCustomTextfield extends StatefulWidget {
  final String hint;
  final String label;
  final IconData icon;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  // Email variant
  const LoginCustomTextfield.email({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
  })  : hint = 'UserName',
        label = 'Enter Your UserName',
        icon = Icons.mail_outline,
        obscure = false;

  // Password variant
  const LoginCustomTextfield.password({
    super.key,
    required this.controller,
    this.validator,
    this.onChanged,
  })  : hint = 'Password',
        label = 'Enter Your Password',
        icon = Icons.lock_outline,
        obscure = true;

  @override
  State<LoginCustomTextfield> createState() => _LoginCustomTextfieldState();
}

class _LoginCustomTextfieldState extends State<LoginCustomTextfield> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.label} :',
          style: TextStyle(
            fontSize: 14.dp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
          ),
        ),
        SizedBox(height: 8.dp),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          obscureText: widget.obscure ? _obscureText : false,
          decoration: InputDecoration(
            hoverColor: Colors.transparent,
            prefixIcon: Icon(
              widget.icon,
              color: const Color(0xFF9CA3AF),
              weight: 0.5,
              size: 20.dp,
            ),
            suffixIcon: widget.obscure
                ? IconButton(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      weight: 0.5,
                      size: 20.dp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.dp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.dp, horizontal: 16.dp),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFFD1D5DB),
                width: 1.dp,
              ),
              borderRadius: BorderRadius.circular(8.dp),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFFD1D5DB),
                width: 1.dp,
              ),
              borderRadius: BorderRadius.circular(8.dp),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFFD1D5DB),
                width: 1.dp,
              ),
              borderRadius: BorderRadius.circular(8.dp),
            ),
          ),
          style: TextStyle(
            color: const Color.fromARGB(255, 104, 109, 117),
            fontSize: 16.dp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
