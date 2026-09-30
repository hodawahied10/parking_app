import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/Core/Shared_Widgets/CustomeButton.dart';
import 'package:parkingapp/Core/model/User_Model.dart';
import 'package:parkingapp/Features/Auth/SignUp/Presentation/Manager/SignupCubit.dart';

class SignupButton extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;

  const SignupButton({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Customebutton(
      "Sign Up",
      () {
        UserModel user = UserModel(
          name: name.text,
          email: email.text,
          phone: phone.text,
          uid: "",
        );

        context.read<Signupcubit>().SignUpUser(
          user,
          password.text,
        );
      },
    );
  }
}