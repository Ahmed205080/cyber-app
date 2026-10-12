import 'package:flutter/material.dart';

void main() {
  runApp(const CyberApp());
}

class CyberApp extends StatelessWidget {
  const CyberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyber Services',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        primarySwatch: Colors.cyan,
      ),
      home: const CyberHomeScreen(),
    );
  }
}

class CyberHomeScreen extends StatelessWidget {
  const CyberHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161E2E),
        title: const Text('الخدمات الإلكترونية'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'رصيد: 50.00 USD',
                style: TextStyle(
                  color: Color(0xFF00FFCC),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildServiceCard(
              context,
              title: 'شرائح eSIM',
              icon: Icons.sim_card,
              color: Colors.cyan,
              destination: const EsimScreen(),
            ),
            _buildServiceCard(
              context,
              title: 'اتصال VPN',
              icon: Icons.vpn_lock,
              color: Colors.purpleAccent,
              destination: const VpnScreen(),
            ),
            _buildServiceCard(
              context,
              title: 'أرقام وهمية',
              icon: Icons.phone_android,
              color: Colors.greenAccent,
              destination: const FakeNumbersScreen(),
            ),
            _buildServiceCard(
              context,
              title: 'الدعم الفني',
              icon: Icons.headset_mic,
              color: Colors.orangeAccent,
              destination: const SupportScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget destination,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EsimScreen extends StatelessWidget {
  const EsimScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161E2E),
        title: const Text('شرائح eSIM'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPackageCard('باقة أمريكا - 10 جيجابايت', '15.00 USD', Colors.cyan),
          _buildPackageCard('باقة أوروبا - 20 جيجابايت', '25.00 USD', Colors.cyan),
          _buildPackageCard('باقة دولية مفتوحة', '45.00 USD', Colors.cyan),
        ],
      ),
    );
  }

  Widget _buildPackageCard(String name, String price, Color color) {
    return Card(
      color: const Color(0xFF161E2E),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.sim_card, color: color),
        title: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        trailing: Text(price, style: const TextStyle(color: Color(0xFF00FFCC), fontWeight: FontWeight.bold)),
        onTap: () {},
      ),
    );
  }
}

class VpnScreen extends StatefulWidget {
  const VpnScreen({Key? key}) : super(key: key);

  @override
  State<VpnScreen> createState() => _VpnScreenState();
}

class _VpnScreenState extends State<VpnScreen> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161E2E),
        title: const Text('اتصال VPN السريع'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.vpn_lock,
              size: 100,
              color: isConnected ? Colors.greenAccent : Colors.purpleAccent,
            ),
            const SizedBox(height: 24),
            Text(
              isConnected ? 'متصل الآن بأمان' : 'غير متصل',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isConnected ? Colors.greenAccent : Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isConnected ? Colors.redAccent : Colors.cyan,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                setState(() {
                  isConnected = !isConnected;
                });
              },
              child: Text(
                isConnected ? 'قطع الاتصال' : 'اتصال الآن',
                style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FakeNumbersScreen extends StatelessWidget {
  const FakeNumbersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161E2E),
        title: const Text('الأرقام الوهمية'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNumberItem('الولايات المتحدة (+1)', '+1 (555) 019-2834', Colors.greenAccent),
          _buildNumberItem('بريطانيا (+44)', '+44 7700 900077', Colors.greenAccent),
          _buildNumberItem('كندا (+1)', '+1 (604) 555-0143', Colors.greenAccent),
        ],
      ),
    );
  }

  Widget _buildNumberItem(String country, String number, Color color) {
    return Card(
      color: const Color(0xFF161E2E),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.phone_android, color: color),
        title: Text(country, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(number, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.copy, color: Colors.cyan),
        onTap: () {},
      ),
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161E2E),
        title: const Text('الدعم الفني والخدمة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.headset_mic, size: 80, color: Colors.orangeAccent),
            const SizedBox(height: 24),
            const Text(
              'كيف يمكننا مساعدتك اليوم؟',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'فريق الدعم متاح على مدار الساعة طوال أيام الأسبوع لمساعدتك في أي استفسار أو مشكلة تقنية.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              icon: const Icon(Icons.chat, color: Colors.black),
              label: const Text('مراسلة الدعم الفني', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
