import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SenangPayFormScreen extends StatelessWidget {
  final String htmlForm;

  SenangPayFormScreen({required this.htmlForm});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SenangPay Payment Form'),
      ),
      body: InAppWebView(
      initialData: InAppWebViewInitialData(
      data: htmlForm,
      baseUrl: Uri.parse('https://app.senangpay.my/payment/827169018481024'),
    ),
    initialOptions: InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
    javaScriptEnabled: true,
    ),
    ),
      ),
    );
  }
}