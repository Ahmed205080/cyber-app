import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class BinancePayService {
  final String apiKey = "YOUR_API_KEY";
  final String secretKey = "YOUR_SECRET_KEY";
  final String baseUrl = "https://bapi.binance.com";

  Future<String?> createOrder({
    required String merchantTradeNo,
    required double totalFee,
    required String currency,
  }) async {
    try {
      final endpoint = "/binancepay/openapi/v2/order";
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final nonce = "123456";

      final bodyMap = {
        "env": {"terminalType": "WEB"},
        "merchantTradeNo": merchantTradeNo,
        "totalFee": totalFee,
        "currency": currency,
        "orderExpireTime": DateTime.now().add(const Duration(minutes: 30)).millisecondsSinceEpoch,
        "goodsDetails": [
          {
            "goodsType": "01",
            "goodsCategory": "D",
            "referenceGoodsId": "cyber_service_01",
            "goodsName": "Cyber Digital Service",
          }
        ]
      };

      final payload = jsonEncode(bodyMap);
      final stringToSign = "$timestamp\n$nonce\n$payload\n";
      
      final keyBytes = utf8.encode(secretKey);
      final messageBytes = utf8.encode(stringToSign);
      final hmac = Hmac(sha512, keyBytes);
      final digest = hmac.convert(messageBytes);
      final signature = digest.toString().toUpperCase();

      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {
          "Content-Type": "application/json",
          "BinancePay-Timestamp": timestamp,
          "BinancePay-Nonce": nonce,
          "BinancePay-Certificate-SN": apiKey,
          "BinancePay-Signature": signature,
        },
        body: payload,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "SUCCESS") {
          return data["data"]["checkoutUrl"];
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
