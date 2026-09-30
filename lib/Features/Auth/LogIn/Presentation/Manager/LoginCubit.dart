import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:parkingapp/Core/model/User_Model.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginState.dart';
import 'package:parkingapp/Features/Auth/LogIn/data/LogiIn_hive.dart';
import 'package:parkingapp/Features/Splash/data/hive_splash.dart';

class Logincubit extends Cubit<Loginstate> {
  Logincubit() : super(LoginInitialState());

  final LogiinHive loginHive = LogiinHive();

  // Login Controllers
  final TextEditingController emailOrPhone = TextEditingController();

  final TextEditingController password = TextEditingController();

  // Forgot Password Controller
  final TextEditingController resetEmail = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  bool googleSignInInitialized = false;

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!googleSignInInitialized) {
      await googleSignIn.initialize(
        serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
      );

      googleSignInInitialized = true;
    }
  }

  // =========================
  // Login
  // =========================

  Future<void> UserLogIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginErrorState("Please fill all fields"));
      return;
    }

    if (!email.contains("@") || !email.contains(".")) {
      emit(LoginErrorState("Please enter a valid email"));
      return;
    }

    emit(LoginLoadingState());

    try {
      UserCredential credentialLogin = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = credentialLogin.user!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .get();

      if (!userDoc.exists) {
        emit(LoginErrorState("User data not found"));
        return;
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      UserModel user = UserModel.fromJson(userData);

      loginHive.UserLogin(email, password);

      SplashHive().saveSplash();
      SplashHive().saveHasAccount();

      emit(LoginSuccessState(user));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  // =========================
  // Google Login
  // =========================

  Future<void> GoogleLogin() async {
    emit(LoginLoadingState());

    try {
      await _ensureGoogleSignInInitialized();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        emit(LoginErrorState("Failed to get Google ID token"));
        return;
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final user = userCredential.user!;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(user.uid)
          .get();

      Map<String, dynamic> userData;

      if (!userDoc.exists) {
        userData = {
          "name": user.displayName,
          "email": user.email,
          "phone": user.phoneNumber,
          "uid": user.uid,
        };

        await FirebaseFirestore.instance
            .collection("user")
            .doc(user.uid)
            .set(userData);
      } else {
        userData = userDoc.data() as Map<String, dynamic>;
      }

      UserModel userGoogle = UserModel.fromJson(userData);

      SplashHive().saveSplash();
      SplashHive().saveHasAccount();

      emit(LoginSuccessState(userGoogle));
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        emit(LoginInitialState());
      } else {
        emit(LoginErrorState(e.description ?? "Google sign-in failed"));
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  // =========================
  // Forgot Password
  // =========================

  Future<void> sendResetPasswordEmail() async {
    final email = resetEmail.text.trim();

    if (email.isEmpty) {
      emit(LoginErrorState("Please enter your email"));
      return;
    }

    if (!email.contains("@") || !email.contains(".")) {
      emit(LoginErrorState("Please enter a valid email"));
      return;
    }

    emit(LoginLoadingState());

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      emit(ForgotPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.message ?? "Failed to send reset email"));
    } catch (e) {
      emit(LoginErrorState("Something went wrong"));
    }
  }

  // =========================
  // Logout
  // =========================

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      loginHive.deleteUser();

      SplashHive().logout();

      emit(LoginInitialState());
    } catch (e) {
      emit(LoginErrorState("Logout failed"));
    }
  }

  // =========================
  // Check Login
  // =========================

  void checkLogin() {
    var email = loginHive.getEmail();
    var password = loginHive.getPassword();

    if (email != null && password != null) {
      emit(LoginLoadingState());
    } else {
      emit(LoginInitialState());
    }
  }

  // =========================
  // Dispose
  // =========================

  @override
  Future<void> close() {
    emailOrPhone.dispose();
    password.dispose();
    resetEmail.dispose();

    return super.close();
  }
}
