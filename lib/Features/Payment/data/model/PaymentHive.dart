
import 'package:hive/hive.dart';

class PaymentHive {
  final Box box = Hive.box('payment');

  void savePayment(String paymentMethod) {
    box.put('paymentMethod', paymentMethod);
  }

  String? getPayment() {
    return box.get('paymentMethod');
  }

  void deletePayment() {
    box.delete('paymentMethod');
  }
}
