import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:parkingapp/Core/model/User_Model.dart';
import 'package:parkingapp/Features/Auth/SignUp/Presentation/Manager/SignupState.dart';
import 'package:parkingapp/Features/Auth/SignUp/data/model/SignUp_hive.dart';
import 'package:parkingapp/Features/Splash/data/hive_splash.dart';

class Signupcubit extends Cubit<Signupstate> {
  Signupcubit() : super(SignUpInitialState());

  final SignupHive signupHive = SignupHive();
  Future<void> SignUpUser(UserModel user, String password) async {
    if (user.name.isEmpty ||
        user.email.isEmpty ||
        user.phone.isEmpty ||
        password.isEmpty) {
      emit(SignUpErrorState("Please fill all fields"));
      return;
    }
    if (password.length < 8) {
      emit(SignUpErrorState("Password must be at least 8 characters"));
      return;
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      emit(SignUpErrorState("Password must contain an uppercase letter"));
      return;
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      emit(SignUpErrorState("Password must contain a lowercase letter"));
      return;
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      emit(SignUpErrorState("Password must contain a number"));
      return;
    }

    if (!RegExp(r'[!@#$%^&*]').hasMatch(password)) {
      emit(SignUpErrorState("Password must contain a special character"));
      return;
    }
    emit(SignUpLoadingState());
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;

      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      final uid = credential.user!.uid;
      user.uid = uid;
      await credential.user!.updateDisplayName(user.name);
      await credential.user!.reload();
      await FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .set(user.toJson());
      signupHive.saveuser(user);
      SplashHive().saveHasAccount();

      emit(SignUpSuccessState(user));
    } catch (e) {
      emit(SignUpErrorState(e.toString()));
    }
  }

  void checkSignUp() {
    var user = signupHive.getUser();
    if (user != null) {
      emit(SignUpSuccessState(user));
    } else {
      emit(SignUpInitialState());
    }
  }
}
