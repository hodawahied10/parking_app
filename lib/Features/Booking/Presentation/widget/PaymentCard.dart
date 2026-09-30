import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/ColorManager.dart';
import 'package:parkingapp/Features/Booking/Presentation/widget/BookingCalculator.dart';

class PaymentCard extends StatelessWidget {
  final double price;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;

  const PaymentCard({
    super.key,
    required this.price,
    required this.startTimeController,
    required this.endTimeController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([startTimeController, endTimeController]),
      builder: (context, child) {
        final total = BookingCalculator.calculateTotal(
          startTime: startTimeController.text,
          endTime: endTimeController.text,
          price: price,
        );

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ColorManager.primaryBG, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pricing',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),

              SizedBox(height: 6.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price / Hour',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF757B87),
                    ),
                  ),
                  Text(
                    '${price.toStringAsFixed(2)} EGP',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 8.h),

              Divider(color: const Color(0xFFE0E3E7), height: 1.h),

              SizedBox(height: 8.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${total.toStringAsFixed(2)} EGP',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
