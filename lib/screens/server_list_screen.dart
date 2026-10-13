import 'package:flutter/material.dart';
import '../services/vpn_service.dart';

class ServerListScreen extends StatefulWidget {
  const ServerListScreen({Key? key}) : super(key: key);

  @override
  _ServerListScreenState createState() => _ServerListScreenState();
}

class _ServerListScreenState extends State<ServerListScreen> {
  final VpnService _vpnService = VpnService();
  List<VpnServer> _servers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadServers();
  }

  void _loadServers() async {
    // يمكنك استبدال الرمز التعييني (Token) برمز المستخدم الفعلي بعد تسجيل الدخول
    String dummyToken = "user_premium_token_123";
    List<VpnServer> servers = await _vpnService.fetchServers(dummyToken);
    
    setState(() {
      _servers = servers;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F19), // الخلفية الداكنة لتطبيق Cyber
      appBar: AppBar(
        title: const Text("قائمة سيرفرات الـ VPN", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.cyanAccent),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
          : _servers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.cloud_off, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        "لا توجد سيرفرات متاحة حالياً.\nتأكد من اتصالك بالسيرفر أو اشتراكك.",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _servers.length,
                  itemBuilder: (context, index) {
                    final server = _servers[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF161B22),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.cyanAccent.withOpacity(0.3)),
                      ),
                      child: ListTile(
                        leading: Text(
                          server.flagEmoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                        title: Text(
                          server.country,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          "IP: ${server.ipAddress}",
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            // عند اختيار السيرفر لبدء الاتصال
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("جاري الاتصال بسيرفر ${server.country}..."),
                                backgroundColor: Colors.cyan,
                              ),
                            );
                          },
                          child: const Text("اتصال", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
