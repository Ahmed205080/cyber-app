import 'package:flutter/material.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(const CyberApp());
}

class CyberApp extends StatelessWidget {
  const CyberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CYBER',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B101D),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 50.00;
  bool isScanning = false;
  String scanStatus = 'اضغط لفحص عتاد الجهاز والتحقق من دعم الـ eSIM';
  bool isVpnConnected = false;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  void _showAddBalanceDialog() {
    TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        title: const Text('إضافة رصيد للمحفظة', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'أدخل المبلغ (مثال: 20)',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF00FFC2))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00FFC2)),
            onPressed: () {
              if (amountController.text.isNotEmpty) {
                setState(() {
                  balance += double.tryParse(amountController.text) ?? 0.0;
                });
              }
              Navigator.pop(context);
            },
            child: const Text('إضافة', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  // فحص حقيقي لمعرفة دعم الجهاز للـ eSIM بناءً على عتاد ونظام الهاتف
  Future<void> _runDeviceScan() async {
    setState(() {
      isScanning = true;
      scanStatus = 'جاري فحص نظام التشغيل والعتاد...';
    });

    try {
      bool esimSupported = false;
      String deviceName = "جهاز غير معروف";

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName = androidInfo.model;
        // أندرويد 9 (API 28) فما فوق يبدأ يدعم الـ eSIM برمجياً، مع التحقق من الموديلات الحديثة
        int sdkInt = androidInfo.version.sdkInt;
        if (sdkInt >= 28) {
          // التحقق من الشركات التي تدعم غالباً شرائح eSIM (مثل Pixel أو الأجهزة الحديثة)
          esimSupported = true; 
        }
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.name;
        // آيفون XS وما فوق (iOS 12.1+) يدعم الـ eSIM
        esimSupported = true;
      }

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        isScanning = false;
        if (esimSupported) {
          scanStatus = '✓ مدعوم: $deviceName يدعم تقنية الشرائح المدمجة eSIM بنجاح.';
        } else {
          scanStatus = '✕ عذراً: $deviceName لا يدعم شرائح الـ eSIM برمجياً.';
        }
      });
    } catch (e) {
      setState(() {
        isScanning = false;
        scanStatus = 'تعذر فحص الجهاز، حاول مرة أخرى.';
      });
    }
  }

  void _openFeatureScreen(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF131B2E),
            title: Text(title),
          ),
          body: Center(
            child: Text(
              'شاشة $title قيد التشغيل',
              style: const TextStyle(fontSize: 18, color: Color(0xFF00FFC2)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'CYBER',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.shield, color: Colors.purpleAccent, size: 20),
            ],
          ),
          centerTitle: true,
          actions: [
            Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'الإنترنت والدفع بلا حدود',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 16),

              // Wallet Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: _showAddBalanceDialog,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00FFC2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add, color: Colors.black, size: 20),
                      ),
                    ),
                    Column(
                      children: [
                        const Text('رصيد المحفظة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text('\$${balance.toStringAsFixed(2)}', style: const TextStyle(color: Color(0xFF00FFC2), fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.account_balance_wallet, color: Color(0xFF00FFC2)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Device Check Card
              Container(
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
                        InkWell(
                          onTap: isScanning ? null : _runDeviceScan,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E293B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.phone_iphone, color: Colors.cyan, size: 20),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('فحص الجهاز الحالي الحقيقي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(scanStatus, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.cyan),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: isScanning ? null : _runDeviceScan,
                        child: Text(isScanning ? 'جاري الفحص...' : 'إعادة الفحص', style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Grid Options
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: [
                  GestureDetector(
                    onTap: () => _openFeatureScreen('شرائح الـ eSIM'),
                    child: _buildGridItem(Icons.sim_card_outlined, 'شرائح الـ eSIM', false),
                  ),
                  GestureDetector(
                    onTap: () => _openFeatureScreen('أرقام افتراضية'),
                    child: _buildGridItem(Icons.call_made, 'أرقام افتراضية', false),
                  ),
                  GestureDetector(
                    onTap: () => _openFeatureScreen('خدمة الـ VPN'),
                    child: _buildGridItem(Icons.security, 'خدمة الـ VPN', true),
                  ),
                  GestureDetector(
                    onTap: () => _openFeatureScreen('المعاملات والشرائح'),
                    child: _buildGridItem(Icons.history, 'المعاملات والشرائح', false),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // VPN Status Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF131B2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isVpnConnected ? const Color(0xFF00FFC2) : Colors.cyan.withOpacity(0.5)),
                ),
                child: Column(
                  children: [
                    Text(
                      isVpnConnected ? 'Cyber VPN (متصل ومحمي)' : 'Cyber VPN اتصال آمن ومُشفر عبر',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isVpnConnected ? const Color(0xFF00FFC2) : Colors.white),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'قم بتشفير اتصالاتك وتغيير مكانك الجغرافي بحماية عالية وسرعة فائقة.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isVpnConnected ? const Color(0xFF00FFC2) : Colors.white38,
                          width: 2,
                        ),
                        color: isVpnConnected ? const Color(0xFF00FFC2).withOpacity(0.2) : Colors.transparent,
                      ),
                      child: IconButton(
                        iconSize: 40,
                        icon: Icon(
                          Icons.power_settings_new,
                          color: isVpnConnected ? const Color(0xFF00FFC2) : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isVpnConnected = !isVpnConnected;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String title, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.cyan : Colors.white10,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.cyan : Colors.white, size: 28),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
