import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:parkingapp/Core/Theme/AppAssets.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

import 'package:parkingapp/Features/Payment/data/Presentation/Manager/PaymentCubit.dart';
import 'package:parkingapp/Features/Payment/data/Presentation/Manager/PaymentState.dart';

import 'package:parkingapp/Features/Payment/data/Presentation/widget/PaymentOption.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        final cubit = context.read<PaymentCubit>();

        String? selectedMethod = cubit.selectedPaymentMethod;

        bool rememberPayment = false;

        if (state is PaymentSelectedState) {
          selectedMethod = state.paymentMethod;
          rememberPayment = state.rememberPayment;
        }

        if (state is PaymentSavedState) {
          selectedMethod = state.paymentMethod;
          rememberPayment = true;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.titleColor,
              ),
            ),

            SizedBox(height: 12.h),

            PaymentOption(
              name: 'Apple Pay',
              image: Appassets.appleImage,
              isSelected: selectedMethod == 'Apple Pay',
              onTap: () {
                cubit.selectPaymentMethod('Apple Pay');
              },
            ),

            PaymentOption(
              name: 'PayPal',
              image: Appassets.payImage,
              isSelected: selectedMethod == 'PayPal',
              onTap: () {
                cubit.selectPaymentMethod('PayPal');
              },
            ),

            PaymentOption(
              name: 'Mastercard',
              image: Appassets.creditImage,
              isSelected: selectedMethod == 'Mastercard',
              onTap: () {
                cubit.selectPaymentMethod('Mastercard');
              },
            ),

            PaymentOption(
              name: 'Visa',
              image: Appassets.visaImage,
              isSelected: selectedMethod == 'Visa',
              onTap: () {
                cubit.selectPaymentMethod('Visa');
              },
            ),

            PaymentOption(
              name: 'Cash',
              image: Appassets.cashImage,
              isSelected: selectedMethod == 'Cash',
              onTap: () {
                cubit.selectPaymentMethod('Cash');
              },
            ),

            SizedBox(height: 8.h),

            Row(
              children: [
                Checkbox(
                  value: rememberPayment,
                  activeColor: ColorManager.buttonColor,
                  onChanged: (value) {
                    if (selectedMethod == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please select a payment method first',
                          ),
                        ),
                      );

                      return;
                    }

                    if (value == true) {
                      cubit.savePaymentMethod(
                        selectedMethod,
                      );
                    } else {
                      cubit.deleteSavedPaymentMethod();
                    }
                  },
                ),

                Text(
                  'Remember Payment Method',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorManager.titleColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}