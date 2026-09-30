
import 'package:parkingapp/Core/model/User_Model.dart';

abstract class Loginstate {}

class LoginInitialState extends Loginstate {}

class LoginLoadingState extends Loginstate {}

class LoginSuccessState extends Loginstate {
  UserModel user;

  LoginSuccessState(this.user);
}

class ForgotPasswordSuccessState extends Loginstate {}

class LoginErrorState extends Loginstate {
  String message;

  LoginErrorState(this.message);
}
