import 'package:hive/hive.dart';
import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';

class BookingHive {
  final Box box = Hive.box('bookings');

  void saveBooking(BookingModel booking) {
    box.add(booking);
  }

  List<BookingModel> getBookings() {
    return box.values.cast<BookingModel>().toList();
  }

  void deleteBooking(int index) {
    box.deleteAt(index);
  }

  void testDeleteBookingByData(BookingModel booking) {
    final keys = box.keys.toList();

    for (final key in keys) {
      final storedBooking = box.get(key);

      if (storedBooking is! BookingModel) {
        continue;
      }

      final isSameBooking =
          storedBooking.garageId == booking.garageId &&
          storedBooking.levelId == booking.levelId &&
          storedBooking.spotNumber == booking.spotNumber &&
          storedBooking.date == booking.date &&
          storedBooking.startTime == booking.startTime &&
          storedBooking.endTime == booking.endTime;

      if (isSameBooking) {
        box.delete(key);
        return;
      }
    }
  }

  void clearBookings() {
    box.clear();
  }
}