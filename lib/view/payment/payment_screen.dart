import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pet_app/view/payment/paymob_service.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymobManager _paymobManager = PaymobManager();
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
          startPayment();
        },
      ),
    );
  }

  void startPayment() async {
    try {
      final paymentToken = await _paymobManager.payWithPaymob(500); // Example amount: 100 EGP
      final paymentUrl = 'https://accept.paymob.com/api/acceptance/iframes/${_paymobManager.getIframeId()}?payment_token=$paymentToken';

      _webViewController?.loadUrl(
        urlRequest: URLRequest(
          url: WebUri(paymentUrl), // Convert Uri to WebUri
        ),
      );
    } catch (e) {
      print("Payment initiation failed: $e");
    }
  }
}
