
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/widget/booking.dart';
import 'package:parkingapp/Features/Payment/data/model/PaymentArguments.dart';

class Bookingdetails extends StatelessWidget {
  final PaymentArguments args;

  const Bookingdetails({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return 
    
       Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text( "Booking Details",
                        style: TextStyle(
              color: ColorManager.titleColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
                        ),),
            ),
          SizedBox(height: 10.h,),
            Booking(
              title: "Spot",
              value: args.spot.number.toString(),
            ),

            SizedBox(height: 20.h),

            Booking(
              title: "Level",
              value: args.level.level,
            ),

            SizedBox(height: 20.h),

            Booking(
              title: "Date",
              value: args.booking.date,
            ),

            SizedBox(height: 20.h),

            Booking(
              title: "Time",
              value:
                  "${args.booking.startTime} - ${args.booking.endTime}",
            ),

            SizedBox(height: 20.h),

            Booking(
              title: "Vehicle",
              value: args.booking.carId,
            ),
          ],
        ),
      );
    
  }
}
