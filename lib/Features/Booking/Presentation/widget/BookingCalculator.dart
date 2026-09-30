import 'package:parkingapp/Core/Utils/BookingUtils.dart';

class BookingCalculator {
  static double calculateTotal({
    required String startTime,
    required String endTime,
    required double price,
  }) {
    if (startTime.trim().isEmpty || endTime.trim().isEmpty || price <= 0) {
      return 0;
    }

    final startMinutes = BookingUtils.timeToMinutes(startTime);

    final endMinutes = BookingUtils.timeToMinutes(endTime);

    if (endMinutes <= startMinutes) {
      return 0;
    }

    final durationMinutes = endMinutes - startMinutes;

    final hours = durationMinutes / 60;

    return hours * price;
  }
}
