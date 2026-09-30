import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Booking/Presentation/Manager/BookingCubit.dart';
import 'package:parkingapp/Features/Booking/Presentation/Manager/BookingState.dart';
import 'package:parkingapp/Features/Booking/Presentation/widget/BookingButton.dart';
import 'package:parkingapp/Features/Booking/Presentation/widget/BookingField.dart';
import 'package:parkingapp/Features/Booking/Presentation/widget/PaymentCard.dart';

import 'package:parkingapp/Features/Payment/data/model/PaymentArguments.dart';

import 'package:parkingapp/Features/Home/data/model/ParkingLevel.dart';
import 'package:parkingapp/Features/Home/data/model/ParkingSpot.dart';

class BookingScreen extends StatelessWidget {
  static const String routeName = "/BookingScreen";

  final ParkingLevel level;
  final ParkingSpot spot;

  // Garage ID
  final String garageId;

  BookingScreen({
    super.key,
    required this.level,
    required this.spot,
    required this.garageId,
  });

  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController nationalIdController = TextEditingController();

  final TextEditingController carIdController = TextEditingController();

  final TextEditingController startTimeController = TextEditingController();

  final TextEditingController endTimeController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<BookingCubit, BookingState>(
        listener: (context, state) {
          if (state is BookingSuccessState) {
            final args = PaymentArguments(
              booking: state.booking,
              spot: spot,
              level: level,
            );

            context.push(Routes.paymentScreen, extra: args);
          }

          if (state is BookingErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.primaryBG,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            title: Text(
              "Booking Form",
              style: TextStyle(
                color: ColorManager.titleColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  Bookingfield(
                    fullNameController: fullNameController,
                    phoneController: phoneController,
                    nationalIdController: nationalIdController,
                    carIdController: carIdController,
                    startTimeController: startTimeController,
                    endTimeController: endTimeController,
                    dateController: dateController,
                  ),

                  SizedBox(height: 10.h),

                  PaymentCard(
                    price: level.price,
                    startTimeController: startTimeController,
                    endTimeController: endTimeController,
                  ),

                  SizedBox(height: 10.h),

                  BookingButton(
                    fullName: fullNameController,
                    phone: phoneController,
                    nationalId: nationalIdController,
                    carId: carIdController,
                    startTime: startTimeController,
                    endTime: endTimeController,
                    date: dateController,
                    price: level.price,

                    // Parking information
                    garageId: garageId,
                    levelId: level.level,
                    spotNumber: spot.number,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
