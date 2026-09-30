import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkingapp/Features/Splash/Presentation/Manager/Splash_state.dart';
import 'package:parkingapp/Features/Splash/data/hive_splash.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoadingState()) {
    checkUser();
  }

  final SplashHive splashHive = SplashHive();

  Future<void> checkUser() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      final isFirstTime = splashHive.getSplash();

      print("isFirstTime: $isFirstTime");

      final user = FirebaseAuth.instance.currentUser;

      print("Firebase user: ${user?.email}");
      print("Firebase uid: ${user?.uid}");

      if (isFirstTime) {
        emit(SplashFirstTimeState());
      } else if (user != null) {
        emit(SplashLoggedInState());
      } else {
        emit(SplashLoggedOutState());
      }
    } catch (e) {
      emit(SplashErrorState(e.toString()));
    }
  }
}
