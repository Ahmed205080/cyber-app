import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CyberApp());
}

class CyberApp extends StatelessWidget {
  const CyberApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyber App - لوحة الخدمات الرقمية',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070B14),
        primarySwatch: Colors.cyan,
      ),
      home: const CyberHomeScreen(),
    );
  }
}

class CyberHomeScreen extends StatefulWidget {
  const CyberHomeScreen({Key? key}) : super(key: key);

  @override
  State<CyberHomeScreen> createState() => _CyberHomeScreenState();
}

class _CyberHomeScreenState extends State<CyberHomeScreen> {
  bool isVpnConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D121F),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
        ),
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'CYBER',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.shield_rounded, color: Color(0xFF8B5CF6), size: 20),
              ],
            ),
            const Text(
              'الإنترنت والدفع بلا حدود',
              style: TextStyle(fontSize: 9, color: Colors.grey),
            ),
          ],
        ),
        centerTitle: true,
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
            // بطاقة الرصيد والمحفظة
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyan.withOpacity(0.15)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF00FFCC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.black, size: 22),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم النقر لشحن المحفظة')),
                        );
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'رصيد المحفظة',
                        style: TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '\$50.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00FFCC),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D3B48),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF00FFCC), size: 22),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // بطاقة فحص الجهاز الحالي
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.cyan.withOpacity(0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.cyan.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.phone_iphone, color: Colors.cyan, size: 26),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'iPhone 14 Pro',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text(
                                'فحص الجهاز الحالي:',
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'جهازك يدعم تقنية الشرائح المدمجة (eSIM) وجاهز للتفعيل الفوري',
                                style: TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.check_box, color: Colors.greenAccent, size: 14),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.cyan.withOpacity(0.3)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: const Color(0xFF0D121F),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('جاري إعادة فحص توافق الجهاز...')),
                        );
                      },
                      child: const Text('إعادة الفحص', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // أزرار الخدمات الأربعة (Grid)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                _buildMenuCard(
                  context,
                  title: 'أرقام افتراضية',
                  icon: Icons.phone_callback,
                  destination: const FakeNumbersScreen(),
                ),
                _buildMenuCard(
                  context,
                  title: 'شرائح الـ eSIM',
                  icon: Icons.sim_card,
                  destination: const EsimScreen(),
                ),
                _buildMenuCard(
                  context,
                  title: 'المعاملات والشرائح',
                  icon: Icons.history,
                  destination: const TransactionsScreen(),
                ),
                _buildMenuCard(
                  context,
                  title: 'خدمة الـ VPN',
                  icon: Icons.admin_panel_settings,
                  isActive: true,
                  destination: const VpnDetailsScreen(),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // قسم التحكم بالـ VPN السفلي
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isVpnConnected ? Colors.greenAccent.withOpacity(0.4) : Colors.cyan.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'اتصال آمن ومُشفر عبر Cyber VPN',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'قم بتشفير اتصالاتك وتغيير مكانك الجغرافي بحماية عالية وسرعة فائقة.',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVpnConnected = !isVpnConnected;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isVpnConnected ? 'تم الاتصال بسيرفر VPN بنجاح' : 'تم قطع اتصال الـ VPN'),
                        ),
                      );
                    },
                    child: Container(
                      width: 85,
                      height: 85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isVpnConnected ? Colors.greenAccent : Colors.cyan,
                          width: 2.5,
                        ),
                        color: (isVpnConnected ? Colors.greenAccent : Colors.cyan).withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.power_settings_new,
                        size: 40,
                        color: isVpnConnected ? Colors.greenAccent : Colors.cyan,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isVpnConnected ? 'متصل الآن بأمان' : 'غير متصل',
                    style: TextStyle(
                      color: isVpnConnected ? Colors.greenAccent : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    bool isActive = false,
    required Widget destination,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Colors.cyan : Colors.cyan.withOpacity(0.12),
          width: isActive ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 28, color: isActive ? Colors.cyan : Colors.white70),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 1. شاشة الأرقام الافتراضية
class FakeNumbersScreen extends StatelessWidget {
  const FakeNumbersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0D121F), title: const Text('الأرقام الافتراضية')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNumberCard(context, 'الولايات المتحدة (+1)', '+1 (555) 019-2834'),
          _buildNumberCard(context, 'بريطانيا (+44)', '+44 7700 900077'),
          _buildNumberCard(context, 'كندا (+1)', '+1 (604) 555-0143'),
        ],
      ),
    );
  }

  Widget _buildNumberCard(BuildContext context, String country, String number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.cyan.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: const Icon(Icons.phone_android, color: Colors.greenAccent),
        title: Text(country, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(number, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.copy, color: Colors.cyan),
        onTap: () {
          Clipboard.setData(ClipboardData(text: number));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم نسخ الرقم: $number للحافظة!')),
          );
        },
      ),
    );
  }
}

// 2. شاشة شرائح الـ eSIM
class EsimScreen extends StatelessWidget {
  const EsimScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF0D121F), title: const Text('شرائح الـ eSIM')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEsimCard(context, 'باقة أمريكا - 10 جيجابايت', '\$15.00'),
          _buildEsimCard(context, 'باقة أوروبا - 20 جيجابايت', '\$25.00'),
          _buildEsimCard(context, 'باقة دولية مفتوحة', '\$45.00'),
        ],
      ),
    );
  }

  Widget _buildEsimCard(BuildContext context, String title, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.cyan.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: const Icon(Icons.sim_card
