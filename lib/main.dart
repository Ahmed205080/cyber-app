import 'package:flutter/material.dart';

void main() {
  runApp(const CyberApp());
}

class CyberApp extends StatelessWidget {
  const CyberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyber App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        primaryColor: const Color(0xFF00FFCC),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CYBER SERVICES'),
        backgroundColor: const Color(0xFF161E2E),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: Text(
                'رصيد: \$50.00',
                style: TextStyle(color: Color(0xFF00FFCC), fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: const [
            DashboardCard(icon: Icons.sim_card, title: 'شرايح eSIM'),
            DashboardCard(icon: Icons.vpn_lock, title: 'خدمة VPN'),
            DashboardCard(icon: Icons.phone_android, title: 'أرقام افتراضية'),
            DashboardCard(icon: Icons.wallet, title: 'المحفظة'),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const DashboardCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161E2E),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF1F293D)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: const Color(0xFF00FFCC)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
