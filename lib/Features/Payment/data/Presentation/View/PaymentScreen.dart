import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Shared_Widgets/CustomeButton.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Payment/data/Presentation/Manager/PaymentCubit.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/Manager/PaymentState.dart';

import 'package:parkingapp/Features/Payment/data/Presentation/widget/BookingSummary%20.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/widget/PaymentMethod.dart';
import 'package:parkingapp/Features/Payment/data/model/PaymentArguments.dart';

class PaymentScreen extends StatelessWidget {
  static const String routeName = "/PaymentScreen";

  final PaymentArguments args;

  const PaymentScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    print("=== PAYMENT SCREEN BUILD ===");
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) {
        // No payment method selected
        if (state is PaymentErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }

        // Payment success
        if (state is PaymentSuccessState) {
          context.push(
            Routes.confirmationscreen,
            extra: {'args': args, 'paymentMethod': state.paymentMethod},
          );
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
            "Payment",
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
                BookingSummary(booking: args.booking, spot: args.spot),

                SizedBox(height: 10.h),

                PaymentMethod(),

                SizedBox(height: 40.h),

                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    if (state is PaymentProcessingState) {
                      return Customebutton("Processing...", () {});
                    }

                    return Customebutton("Confirm & Pay", () {
                      context.read<PaymentCubit>().confirmPayment();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
