import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:parkingapp/Features/Notification/Data/model/service/NotificationService.dart';

import 'package:parkingapp/Features/Payment/data/Presentation/Manager/PaymentState.dart';
import 'package:parkingapp/Features/Payment/data/model/PaymentHive.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitialState());

  final PaymentHive paymentHive = PaymentHive();

  final FirebaseAuth auth = FirebaseAuth.instance;

  final NotificationService notificationService = NotificationService();

  String? selectedPaymentMethod;

  void selectPaymentMethod(String paymentMethod) {
    selectedPaymentMethod = paymentMethod;

    bool rememberPayment = false;

    final savedPaymentMethod = paymentHive.getPayment();

    if (savedPaymentMethod != null && savedPaymentMethod == paymentMethod) {
      rememberPayment = true;
    }

    emit(PaymentSelectedState(paymentMethod, rememberPayment: rememberPayment));
  }

  void savePaymentMethod(String paymentMethod) {
    try {
      selectedPaymentMethod = paymentMethod;

      paymentHive.savePayment(paymentMethod);

      emit(PaymentSavedState(paymentMethod));
    } catch (e) {
      emit(PaymentErrorState(e.toString()));
    }
  }

  void getSavedPaymentMethod() {
    try {
      final paymentMethod = paymentHive.getPayment();

      if (paymentMethod != null) {
        selectedPaymentMethod = paymentMethod;

        emit(PaymentSavedState(paymentMethod));
      } else {
        selectedPaymentMethod = null;

        emit(PaymentInitialState());
      }
    } catch (e) {
      emit(PaymentErrorState(e.toString()));
    }
  }

  void deleteSavedPaymentMethod() {
    try {
      paymentHive.deletePayment();

      if (selectedPaymentMethod != null) {
        emit(
          PaymentSelectedState(selectedPaymentMethod!, rememberPayment: false),
        );
      } else {
        emit(PaymentDeletedState());
      }
    } catch (e) {
      emit(PaymentErrorState(e.toString()));
    }
  }

  Future<void> confirmPayment() async {
    String? paymentMethod;

    if (state is PaymentSelectedState) {
      paymentMethod = (state as PaymentSelectedState).paymentMethod;
    } else if (state is PaymentSavedState) {
      paymentMethod = (state as PaymentSavedState).paymentMethod;
    }

    if (paymentMethod == null || paymentMethod.trim().isEmpty) {
      emit(PaymentErrorState('Please select a payment method'));

      return;
    }

    emit(PaymentProcessingState());

    await handlePaymentSuccess(paymentMethod);
  }

  Future<void> handlePaymentSuccess(String paymentMethod) async {
    try {
      final user = auth.currentUser;

      if (user == null) {
        emit(PaymentErrorState("User is not logged in."));

        return;
      }

      await notificationService.createPaymentSuccessfulNotification(
        userId: user.uid,
      );

      await notificationService.createGateAccessNotification(userId: user.uid);

      if (isClosed) {
        return;
      }

      emit(PaymentSuccessState(paymentMethod));
    } catch (e) {
      if (!isClosed) {
        emit(PaymentErrorState(e.toString()));
      }
    }
  }
}
