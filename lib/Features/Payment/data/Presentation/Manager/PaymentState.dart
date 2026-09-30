abstract class PaymentState {}

class PaymentInitialState extends PaymentState {}

class PaymentSelectedState extends PaymentState {
  final String paymentMethod;
  final bool rememberPayment;

  PaymentSelectedState(this.paymentMethod, {this.rememberPayment = false});
}

class PaymentSavedState extends PaymentState {
  final String paymentMethod;

  PaymentSavedState(this.paymentMethod);
}

class PaymentDeletedState extends PaymentState {}

class PaymentProcessingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {
  final String paymentMethod;

  PaymentSuccessState(this.paymentMethod);
}

class PaymentErrorState extends PaymentState {
  final String message;

  PaymentErrorState(this.message);
}
