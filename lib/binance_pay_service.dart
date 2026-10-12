import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class BinancePayService {
  // ⚠️ استبدل هذه المفاتيح بمفاتيح API التي قمت بنسخها من بينانس
  final String apiKey = "GroKreJhZi882UhQCl7eWbSsMxusID6RE4jXBkB56dUD80wAAg8MFqj4lN4Qy5Dy";
  final String secretKey = "hmnn7an2Wh75K0n1QbYO6jagviiWjvULorGk0kTZZ6lncu46pXvc2uK7rLkApTzk";

  final String baseUrl = "https://bpay.binanceapi.com/binancepay/openapi/v2/order";

  /// دالة لتوليد التوقيع الرقمي (HMAC-SHA512) المطلوب للأمان من بينانس
  String _generateSignature(String timeStamp, String nonce, String body) {
    String payload = "$timeStamp\n$nonce\n$body\n";
    var key = utf8.encode(secretKey);
    var bytes = utf8.encode(payload);
    var hmacSha512 = Hmac(sha512, key);
    var digest = hmacSha512.convert(bytes);
    return digest.toString().toUpperCase();
  }

  /// دالة إنشاء طلب دفع لشراء باقة VPN أو خدمة في تطبيق Cyber
  Future<Map<String, dynamic>?> createOrder({
    required String merchantTradeNo, // رقم المزيّة/الطلب الفريد (مثال: order_12345)
    required double amount,          // المبلغ بالـ USDT
    required String productName,     // اسم الباقة (مثلاً: Cyber VIP VPN)
  }) async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String nonce = DateTime.now().microsecondsSinceEpoch.toString();

    // جسم الطلب الخاص بـ Binance Pay API
    Map<String, dynamic> requestBody = {
      "env": {
        "terminalType": "APP"
      },
      "merchantTradeNo": merchantTradeNo,
      "orderAmount": amount.toStringAsFixed(2),
      "currency": "USDT",
      "goods": {
        "goodsType": "02", // Virtual goods / خدمات رقمية
        "goodsCategory": "6000",
        "referenceGoodsId": "cyber_vpn_sub",
        "goodsName": productName,
      }
    };

    String jsonPayload = jsonEncode(requestBody);
    String signature = _generateSignature(timeStamp, nonce, jsonPayload);

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'BinancePay-Timestamp': timeStamp,
          'BinancePay-Nonce': nonce,
          'BinancePay-Certificate-SN': apiKey,
          'BinancePay-Signature': signature,
        },
        body:
