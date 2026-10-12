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
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
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
            MaterialPageRoute(
              builder: (context) => ServiceDetailScreen(
                title: title,
                icon: icon,
                color: color,
              ),
            ),
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

class ServiceDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const ServiceDetailScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161E2E),
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: color),
              const SizedBox(height: 24),
              Text(
                'قسم $title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'جاري تجهيز محتوى وطبيعة هذه الخدمة...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
