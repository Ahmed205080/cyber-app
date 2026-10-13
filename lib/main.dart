import 'package:flutter/material.dart';

void main() {
  runApp(const CyberApp());
}

class CyberApp extends StatelessWidget {
  const CyberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CYBER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFA3),
          surface: Color(0xFF131B2E),
        ),
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  bool _isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade800,
              child: const Icon(Icons.person, color: Colors.white70),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'CYBER',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.shield, color: Color(0xFF8A2BE2), size: 24),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. محفظة الرصيد
              _buildWalletCard(),
              const SizedBox(height: 16),

              // 2. فحص الجهاز الحالي (eSIM)
              _buildDeviceCheckCard(),
              const SizedBox(height: 16),

              // 3. شبكة الخدمات الاربع
              _buildServicesGrid(),
              const SizedBox(height: 20),

              // 4. كارت اتصال Cyber VPN السريع
              _buildVpnConnectionCard(),
            ],
          ),
        ),
      ),
    );
  }

  // بطاقة المحفظة
  Widget _buildWalletCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF00FFA3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.black, size: 28),
              onPressed: () {},
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'رصيد المحفظة',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 4),
              Text(
                '\$50.00',
                style: TextStyle(
                  color: Color(0xFF00FFA3),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.account_balance_wallet, color: Color(0xFF00FFA3)),
          ),
        ],
      ),
    );
  }

  // بطاقة فحص الجهاز
  Widget _buildDeviceCheckCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.smartphone, color: Color(0xFF00E5FF)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'iPhone 14 Pro :فحص الجهاز الحالي',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.check_box, color: Colors.green, size: 16),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'وجاهز للتفعيل الفوري (eSIM) جهازك يدعم تقنية الشرائح المدمجة',
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF1E293B)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('إعادة الفحص', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // شبكة الخدمات
  Widget _buildServicesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildServiceCard('شرائح الـ eSIM', Icons.sim_card_outlined, () {}),
        _buildServiceCard('أرقام افتراضية', Icons.phone_callback_outlined, () {}),
        _buildServiceCard('خدمة الـ VPN', Icons.verified_user_outlined, () {}, isSelected: true),
        _buildServiceCard('المعاملات والشرائح', Icons.history, () {}),
      ],
    );
  }

  Widget _buildServiceCard(String title, IconData icon, VoidCallback onTap, {bool isSelected = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF131B2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF00E5FF) : Colors.white10,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: isSelected ? const Color(0xFF00E5FF) : Colors.white70),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قسم VPN الاتصال
  Widget _buildVpnConnectionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          const Text(
            'اتصال آمن ومُشفر عبر Cyber VPN',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'قم بتشفير اتصالاتك وتغيير مكانك الجغرافي بحماية عالية وسرعة فائقة.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                _isConnected = !_isConnected;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: _isConnected ? const Color(0xFF00FFA3) : Colors.grey.shade700,
                  width: 3,
                ),
                boxShadow: _isConnected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00FFA3).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        )
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  Icons.power_settings_new,
                  size: 42,
                  color: _isConnected ? const Color(0xFF00FFA3) : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
