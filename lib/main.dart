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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                'رصيد: 50.00 USD',
                style: const TextStyle(
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
        child: Column(
          children: [
            Expanded(
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
                  ),
                  _buildServiceCard(
                    context,
                    title: 'اتصال VPN',
                    icon: Icons.vpn_lock,
                    color: Colors.purpleAccent,
                  ),
                  _buildServiceCard(
                    context,
                    title: 'أرقام وهمية',
                    icon: Icons.phone_android,
                    color: Colors.greenAccent,
                  ),
                  _buildServiceCard(
                    context,
                    title: 'الدعم الفني',
                    icon: Icons.headset_mic,
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context,
      {required String title, required IconData icon, required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF161E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: () {},
