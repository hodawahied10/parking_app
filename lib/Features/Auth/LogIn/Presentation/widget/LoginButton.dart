import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/Core/Shared_Widgets/CustomeButton.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginCubit.dart';

class Loginbutton extends StatelessWidget {
  final TextEditingController emailOrPhone;
  final TextEditingController password;

  const Loginbutton({
    super.key,
    required this.emailOrPhone,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Customebutton("Login", () {
      context.read<Logincubit>().UserLogIn(emailOrPhone.text, password.text);
    });
  }
}
