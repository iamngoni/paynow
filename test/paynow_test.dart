import 'package:flutter_test/flutter_test.dart';

import 'package:paynow/paynow.dart';

void main() {
  test('check if cart is working', () {
    final paynow = Paynow();
    final payment = paynow.createPayment("reference", "authEmail");
    payment.add("title", 1.0);
    expect(payment.total(), 1.0);
    
  });
}
