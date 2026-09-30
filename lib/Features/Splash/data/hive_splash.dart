import 'package:hive/hive.dart';

class SplashHive {
  final Box box = Hive.box("Splash");

  void saveSplash() {
    box.put("isFirstTime", false);
  }

  bool getSplash() {
    return box.get("isFirstTime", defaultValue: true);
  }

  void saveHasAccount() {
    box.put("hasAccount", true);
  }

  bool getHasAccount() {
    return box.get("hasAccount", defaultValue: false);
  }

  void logout() {
    box.put("hasAccount", false);
  }

  void deleteSplash() {
    box.delete("isFirstTime");
    box.delete("hasAccount");
  }
}
