import 'package:parkingapp/Features/Booking/Data/model/BookingModel.dart';

class BookingUtils {
  static String getStatus({
    required bool isUpcoming,
    required String date,
    required String startTime,
    required String endTime,
  }) {
    if (!isUpcoming) {
      return "Completed";
    }

    final DateTime? startDateTime = getStartDateTime(
      date: date,
      time: startTime,
    );

    final DateTime? endDateTime = getStartDateTime(date: date, time: endTime);

    if (startDateTime == null || endDateTime == null) {
      return "Upcoming";
    }

    final DateTime now = DateTime.now();

    if (now.isBefore(startDateTime)) {
      return "Upcoming";
    }

    if (now.isBefore(endDateTime)) {
      return "Active";
    }

    return "Completed";
  }

  static bool isUpcoming(BookingModel booking) {
    try {
      final DateTime? bookingDate = parseDate(booking.date);

      if (bookingDate == null) {
        return false;
      }

      final int endMinutes = timeToMinutes(booking.endTime);

      final DateTime bookingEnd = DateTime(
        bookingDate.year,
        bookingDate.month,
        bookingDate.day,
      ).add(Duration(minutes: endMinutes));

      return bookingEnd.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  static DateTime? getStartDateTime({
    required String date,
    required String time,
  }) {
    try {
      final DateTime? parsedDate = parseDate(date);

      if (parsedDate == null) {
        return null;
      }

      final int minutes = timeToMinutes(time);

      return DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
      ).add(Duration(minutes: minutes));
    } catch (e) {
      return null;
    }
  }

  static DateTime? parseDate(String value) {
    try {
      final date = value.trim();

      // ISO format: 2026-08-12
      final isoDate = DateTime.tryParse(date);

      if (isoDate != null) {
        return DateTime(isoDate.year, isoDate.month, isoDate.day);
      }

      // DD/MM/YYYY
      if (date.contains("/")) {
        final parts = date.split("/");

        if (parts.length == 3) {
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      }

      // DD-MM-YYYY
      if (date.contains("-")) {
        final parts = date.split("-");

        if (parts.length == 3) {
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      }

      // 12 Aug 2026
      final parts = date.split(" ");

      if (parts.length == 3) {
        final int? month = monthNumber(parts[1]);

        if (month != null) {
          return DateTime(int.parse(parts[2]), month, int.parse(parts[0]));
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static int timeToMinutes(String time) {
    try {
      final parts = time.trim().split(" ");

      if (parts.length != 2) {
        return 0;
      }

      final timePart = parts[0];
      final period = parts[1].toUpperCase();

      final timeValues = timePart.split(":");

      if (timeValues.length != 2) {
        return 0;
      }

      int hour = int.parse(timeValues[0]);
      final int minute = int.parse(timeValues[1]);

      if (period == "PM" && hour != 12) {
        hour += 12;
      }

      if (period == "AM" && hour == 12) {
        hour = 0;
      }

      return (hour * 60) + minute;
    } catch (e) {
      return 0;
    }
  }

  static int? monthNumber(String month) {
    switch (month.toLowerCase()) {
      case "jan":
      case "january":
        return 1;

      case "feb":
      case "february":
        return 2;

      case "mar":
      case "march":
        return 3;

      case "apr":
      case "april":
        return 4;

      case "may":
        return 5;

      case "jun":
      case "june":
        return 6;

      case "jul":
      case "july":
        return 7;

      case "aug":
      case "august":
        return 8;

      case "sep":
      case "september":
        return 9;

      case "oct":
      case "october":
        return 10;

      case "nov":
      case "november":
        return 11;

      case "dec":
      case "december":
        return 12;

      default:
        return null;
    }
  }
}
