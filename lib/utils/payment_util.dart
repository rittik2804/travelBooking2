import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


import '../screens/senangpay-form-screen.dart';

class PaymentUtils{
  String generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'ORD_$timestamp';
  }

  Future<void> makePayment(String details, double ammount,String order_Id, String nameU, String emailU, String phoneU,BuildContext context) async {;
    try {
      // 1. Set the payment details
      String merchantId = '827169018481024';
      String secretKey = '39853-2042292850';
      String detail = details;
      double amount = ammount;
      String orderId = order_Id;
      String name = nameU;
      String email = emailU;
      String phone = phoneU;
      // 2. Calculate the hash (You may need to implement your hash generation logic)
      String hash = generateSecureHash(secretKey, detail, amount, orderId);
      print(hash);
      print(orderId);

      print(verifySecureHash(hash, secretKey, detail, amount, orderId));
      // 3. Create the payment request data
      Map<String, dynamic> paymentData = {
        'detail': detail,
        'amount': amount.toStringAsFixed(2),
        'order_id': orderId,
        'hash': hash,
        'name': name,
        'email': email,
        'phone': phone,
      };
print(orderId);
      // 4. Send a POST request to the SenangPay API
      String paymentUrl = 'https://app.senangpay.my/payment/$merchantId';
      final response =
      await http.post(Uri.parse(paymentUrl), body: paymentData);
      if (response.statusCode == 200) {
        print('Payment initiated successfully');
        String responseBody = response.body;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SenangPayFormScreen(htmlForm: responseBody,),

        ));

      } else {
        // 6. Handle errors or failures
        print('Payment initiation failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // 7. Handle exceptions
      print('An error occurred during payment initiation: $e');
    }
  }

  bool verifySecureHash(String receivedHash, String secretKey, String detail,
      double amount, String orderId) {
    String expectedHash =
    generateSecureHash(secretKey, detail, amount, orderId);
    return receivedHash == expectedHash;
  }

  String generateSecureHash(
      String secretKey, String detail, double amount, String orderId) {
    String combinedString =
        '$secretKey$detail${amount.toStringAsFixed(2)}$orderId';

    Uint8List bytes = Uint8List.fromList(utf8.encode(combinedString));

    Hmac hmac = Hmac(sha256, utf8.encode(secretKey)); // or use md5 as needed
    Digest digest = hmac.convert(bytes);
    return digest.toString();
  }
}