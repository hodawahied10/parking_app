import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Shared_Widgets/AuthHeader.dart';
import 'package:parkingapp/Core/Shared_Widgets/CustomeButton.dart';

import 'package:parkingapp/Features/MyBooking/Presentation/View/MyBookingScreen.dart';

import 'package:parkingapp/Features/Payment/data/Presentation/widget/BookingDetails.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/widget/EntryPass.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/widget/SuccessAnimation.dart';
import 'package:parkingapp/Features/Payment/data/model/PaymentArguments.dart';

class Confirmationscreen extends StatelessWidget {
  static const String routeName = "/Confirmationscreen";

  final PaymentArguments args;
  final String paymentMethod;

  const Confirmationscreen({
    super.key,
    required this.args,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            left: 15.w,
            right: 15.w,
            bottom: 10.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SuccessAnimation(),

                SizedBox(height: 10.h),

                Authheader(
                  title: "Booking Confirmed!",
                  subtitle:
                      "Your parking spot is reserved and ready.",
                ),

                SizedBox(height: 15.h),

                Bookingdetails(
                  args: args,
                ),

                SizedBox(height: 7.h),

                EntryPass(
                  carId: args.booking.carId,
                ),

                SizedBox(height: 10.h),

                Row(
                  children: [
                    Expanded(
                      child: Customebutton(
                        "Book Another Spot",
                        () {
                          context.push(
                            Routes.parkingspotsscreen,
                            extra: {
                              'garageId': args.booking.garageId,
                              'level': args.level,
                            },
                          );
                        },
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Expanded(
                      child: Customebutton(
                        "View My Booking",
                        () {
                          context.push(
                            MyBookingScreen.routeName,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}