import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';

abstract class BookingState {}

class BookingInitialState extends BookingState {}

class BookingLoadingState extends BookingState {}

class BookingSuccessState extends BookingState {
  final BookingModel booking;

  BookingSuccessState(this.booking);
}

class BookingLoadedState extends BookingState {
  final List<BookingModel> bookings;

  BookingLoadedState(this.bookings);
}

class BookingCancelSuccessState extends BookingState {}

class BookingCancelErrorState extends BookingState {
  final String message;

  BookingCancelErrorState(this.message);
}

class BookingErrorState extends BookingState {
  final String message;

  BookingErrorState(this.message);
}