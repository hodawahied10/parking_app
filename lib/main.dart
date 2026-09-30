import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkingapp/Core/model/User_Model.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';
import 'package:parkingapp/Features/Home/data/model/GarageModel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';
import 'package:parkingapp/ParkingApp.dart';
import 'package:parkingapp/firebase_options.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';
import 'package:parkingapp/Features/Home/data/model/SpotStatus.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ParkingLevelAdapter());
  Hive.registerAdapter(GarageModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

     Hive.registerAdapter(ParkingSpotAdapter());
      Hive.registerAdapter(SpotStatusAdapter());
      Hive.registerAdapter(BookingModelAdapter());
      await Hive.deleteBoxFromDisk("home");
       await Hive.deleteBoxFromDisk('bookings');
  await Hive.openBox("Splash");
  await Hive.openBox("UserSignUp");
  await Hive.openBox("Userlogin");
 await Hive.openBox('bookings');

 await Hive.openBox('payment');

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const Parkingapp());
}
