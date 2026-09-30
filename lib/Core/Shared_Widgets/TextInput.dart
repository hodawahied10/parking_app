import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Textinput extends StatelessWidget {
  final String hinttext;
  final Widget prefixicon;
  final Widget? postfixicon;
  final bool isvisible;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool enabled;

  const Textinput({
    super.key,
    required this.hinttext,
    required this.prefixicon,
    this.postfixicon,
    this.isvisible = true,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: !isvisible,
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hinttext,

        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 10.w),
          child: SizedBox(height: 20.h, width: 20.w, child: prefixicon),
        ),

        suffixIcon: postfixicon == null
            ? null
            : Padding(
                padding: EdgeInsets.only(left: 16.w, right: 10.w),
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Center(child: postfixicon),
                ),
              ),
      ),
    );
  }
}
