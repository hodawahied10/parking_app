import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';

// Auth - Login
import 'package:parkingapp/Features/Auth/LogIn/Presentation/Manager/LoginCubit.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/View/ForgotPasswordScreen.dart';
import 'package:parkingapp/Features/Auth/LogIn/Presentation/View/LoginScreen.dart';

// Auth - Sign Up
import 'package:parkingapp/Features/Auth/SignUp/Presentation/Manager/SignupCubit.dart';
import 'package:parkingapp/Features/Auth/SignUp/Presentation/View/SignupScreen.dart';

// Booking
import 'package:parkingapp/Features/Booking/Presentation/Manager/BookingCubit.dart';
import 'package:parkingapp/Features/Booking/Presentation/View/BookingScreen.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingArguments.dart';

// Home
import 'package:parkingapp/Features/Home/Presentation/Manager/HomeCubit.dart';
import 'package:parkingapp/Features/Home/Presentation/Manager/ParkingSpotsCubit.dart';
import 'package:parkingapp/Features/Home/Presentation/View/AllGaragesScreen.dart';
import 'package:parkingapp/Features/Home/Presentation/View/GarageOverviewScreen.dart';
import 'package:parkingapp/Features/Home/Presentation/View/ParkingSpotsScreen.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';

// Map
import 'package:parkingapp/Features/Map/Presentation/Manager/MapViewCubit.dart';
import 'package:parkingapp/Features/Map/Presentation/View/MapScreen.dart';

// My Booking
import 'package:parkingapp/Features/MyBooking/Presentation/View/MyBookingScreen.dart';

// Notification
import 'package:parkingapp/Features/Notification/Presentation/Manager/NotificationCubit.dart';
import 'package:parkingapp/Features/Notification/Presentation/View/NotificationScreen.dart';

// Payment
import 'package:parkingapp/Features/Payment/data/Presentation/Manager/PaymentCubit.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/View/ConfirmationScreen.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/View/PaymentScreen.dart';
import 'package:parkingapp/Features/Payment/data/model/PaymentArguments.dart';

// Profile
import 'package:parkingapp/Features/Profile/Presentation/Manager/ProfileCubit.dart';
import 'package:parkingapp/Features/Profile/Presentation/View/EditProfileScreen.dart';
import 'package:parkingapp/Features/Profile/Presentation/View/ProfileScreen.dart';

// Splash
import 'package:parkingapp/Features/Splash/Presentation/Manager/Splash_cubit%20.dart';
import 'package:parkingapp/Features/Splash/Presentation/View/SplashScreen.dart';

// Onboarding
import 'package:parkingapp/Features/onBoarding/onBoardingScreen.dart';

class AppRouter {
  static List<GoRoute> routes = [
    // Splash
    GoRoute(
      path: Routes.splashScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => SplashCubit(),
        child: const Splashscreen(),
      ),
    ),

    // Onboarding
    GoRoute(
      path: Routes.onboardingScreen,
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Sign Up
    GoRoute(
      path: Routes.signupScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => Signupcubit(),
        child: SignupScreen(),
      ),
    ),

    // Login
    GoRoute(
      path: Routes.loginScrren,
      builder: (context, state) =>
          BlocProvider(create: (context) => Logincubit(), child: Loginscreen()),
    ),

    // Forgot Password
    GoRoute(
      path: Routes.forgotPasswordScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => Logincubit(),
        child: const ForgotPasswordScreen(),
      ),
    ),

    // Garage Overview / Home
    GoRoute(
      path: Routes.garageoverviewscreen,
      builder: (context, state) => BlocProvider(
        create: (context) => HomeCubit()..getGarages(),
        child: Garageoverviewscreen(),
      ),
    ),

    // Parking Spots
    GoRoute(
      path: Routes.parkingspotsscreen,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        final String garageId = data['garageId'] as String;
        final ParkingLevel level = data['level'] as ParkingLevel;

        return BlocProvider(
          create: (context) => ParkingSpotsCubit(level),
          child: Parkingspotsscreen(level: level, garageId: garageId),
        );
      },
    ),

    // Booking
    GoRoute(
      path: Routes.bookingScreen,
      builder: (context, state) {
        final args = state.extra as BookingArguments;

        return BlocProvider(
          create: (context) => BookingCubit(),
          child: BookingScreen(
            garageId: args.garageId,
            level: args.level,
            spot: args.spot,
          ),
        );
      },
    ),

    // Payment
    GoRoute(
      path: Routes.paymentScreen,
      builder: (context, state) {
        final args = state.extra as PaymentArguments;

        return BlocProvider(
          create: (context) => PaymentCubit()..getSavedPaymentMethod(),
          child: PaymentScreen(args: args),
        );
      },
    ),

    // Confirmation
    GoRoute(
      path: Routes.confirmationscreen,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return Confirmationscreen(
          args: data['args'] as PaymentArguments,
          paymentMethod: data['paymentMethod'] as String,
        );
      },
    ),

    // My Booking
    GoRoute(
      path: MyBookingScreen.routeName,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => BookingCubit()..getBookings(),
          child: const MyBookingScreen(),
        );
      },
    ),

    // Notifications
    GoRoute(
      path: Routes.notificationScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => NotificationCubit()..getNotifications(),
        child: const NotificationScreen(),
      ),
    ),

    // Profile
    GoRoute(
      path: Routes.profileScreen,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) => Logincubit()),
        ],
        child: const ProfileScreen(),
      ),
    ),

    // Edit Profile
    GoRoute(
      path: Routes.editProfileScreen,
      builder: (context, state) {
        final profileCubit = state.extra as ProfileCubit;

        return BlocProvider.value(
          value: profileCubit,
          child: const EditProfileScreen(),
        );
      },
    ),

    // Map
    GoRoute(
      path: Routes.mapScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => MapCubit(),
        child: const MapScreen(),
      ),
    ),

    // All Garages
    GoRoute(
      path: Routes.allGaragesScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => HomeCubit()..getGarages(),
        child: const AllGaragesScreen(),
      ),
    ),
  ];

  static GoRouter router = GoRouter(
    routes: routes,
    initialLocation: Routes.splashScreen,
  );
}
