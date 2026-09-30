abstract class SplashState {}

class SplashLoadingState extends SplashState {}

class SplashFirstTimeState extends SplashState {}

class SplashLoggedInState extends SplashState {}

class SplashLoggedOutState extends SplashState {}

class SplashNeedsSignupState extends SplashState {}

class SplashErrorState extends SplashState {
  final String message;
  SplashErrorState(this.message);
}
