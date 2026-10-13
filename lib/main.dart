import 'dart:io';
import 'package:flutter/material.dart';
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
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
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
  String deviceName = "جاري التعرف على الجهاز...";
  bool isEsimSupported = false;
  bool isVpnConnected = false;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _checkDeviceEsimSupport();
  }

  // دالة فحص الجهاز حقيقياً
  Future<void> _checkDeviceEsimSupport() async {
    setState(() {
      isScanning = true;
    });

    String name = "جهاز غير معروف";
    bool supported = false;

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        name = "${androidInfo.brand} ${androidInfo.model}";
        supported = androidInfo.version.sdkInt >= 28;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        name = iosInfo.name ?? iosInfo.model;
        supported = !name.toLowerCase().contains("iphone 8") &&
            !name.toLowerCase().contains("iphone 7") &&
            !name.toLowerCase().contains("iphone 6");
      }
    } catch (e) {
      debugPrint("خطأ أثناء فحص الجهاز: $e");
    }

    setState(() {
      deviceName = name;
      isEsimSupported = supported;
      isScanning = false;
    });
  }

  void _showAddBalanceDialog() {
    TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF131B2E),
        title: const Text('إضافة رصيد المحفظة', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'أدخل المبلغ (مثال: 50)',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                balance += double.tryParse(amountController.text) ?? 0.0;
              });
              Navigator.pop(context);
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.security, color: Colors.cyan),
            SizedBox(width: 8),
            Text('CYBER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // بطاقة رصيد المحفظة
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.account_balance_wallet, color: Colors.cyan),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('رصيد المحفظة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(
                        '\$${balance.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.cyanAccent, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _showAddBalanceDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // بطاقة فحص الجهاز (بالأيقونة المصغرة والتحديث الحقيقي)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // الأيقونة المصغرة المطلوبة
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.phone_iphone,
                          size: 18,
                          color: Colors.cyan,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'فحص الجهاز: $deviceName',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Text(
                                      isEsimSupported
                                          ? 'وجاهز للتفعيل الفوري (eSIM) جهازك يدعم التقنية'
                                          : 'جهازك لا يدعم تقنية الشرائح المدمجة (eSIM)',
                                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    isEsimSupported ? Icons.check_box : Icons.disabled_by_default,
                                    color: isEsimSupported ? Colors.green : Colors.red,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: isScanning ? null : _checkDeviceEsimSupport,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: isScanning
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('إعادة الفحص', style: TextStyle(color: Colors.white, fontSize: 12)),
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
}
