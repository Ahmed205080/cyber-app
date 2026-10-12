import 'dart:convert';
import 'package:http/http.dart' as http;

class VpnServer {
  final String id;
  final String country;
  final String flagEmoji;
  final String ipAddress;
  final String configData; // نص تهيئة WireGuard / Xray

  VpnServer({
    required this.id,
    required this.country,
    required this.flagEmoji,
    required this.ipAddress,
    required this.configData,
  });

  factory VpnServer.fromJson(Map<String, dynamic> json) {
    return VpnServer(
      id: json['id'] ?? '',
      country: json['country'] ?? 'Unknown',
      flagEmoji: json['flag'] ?? '🌐',
      ipAddress: json['ip'] ?? '',
      configData: json['config'] ?? '',
    );
  }
}

class VpnService {
  // استبدل هذا الرابط بـ URL الخاص بسيرفرك (VPS API)
  final String apiBaseUrl = "https://your-vps-domain.com/api";

  // جلب قائمة السيرفرات المتاحة
  Future<List<VpnServer>> fetchServers(String userToken) async {
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/servers'),
        headers: {
          'Content-Type': 'json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => VpnServer.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("خطأ في جلب بيانات السيرفرات: $e");
      return [];
    }
  }
}
