import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../binance_pay_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final BinancePayService _binancePayService = BinancePayService();
  bool isLoading = false;

  // دالة بدء عملية الدفع عبر بينانس باي
  void _startBinancePayment(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    // توليد رقم طلب فريد بناءً على الوقت الحالي
    String merchantTradeNo = "CYBER_${DateTime.now().millisecondsSinceEpoch}";
    double packageAmount = 5.00; // سعر باقة الـ VIP مثلاً 5 دولار USDT
    String packageName = "Cyber VPN VIP (1 Month)";

    // استدعاء خدمة بينانس لإنشاء الطلب
    var orderResponse = await _binancePayService.createOrder(
      merchantTradeNo: merchantTradeNo,
      amount: packageAmount,
      productName: packageName,
    );

    setState(() {
      isLoading = false;
    });

    if (orderResponse != null && orderResponse['checkoutUrl'] != null) {
      String checkoutUrl = orderResponse['checkoutUrl'];

      // فتح رابط صفحة الدفع الخاصة بـ بينانس في WebView داخل التطبيق
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BinanceCheckoutWebView(url: checkoutUrl),
        ),
      );
    } else {
      _showError("فشل إنشاء طلب الدفع من بينانس. تأكد من صحة المفاتيح!");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19), // خلفية داكنة تناسب هوية Cyber
      appBar: AppBar(
        title: const Text("ترقية حساب Cyber", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:
