import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String deviceName = "جاري التحقق من الجهاز...";
  bool isEsimSupported = false;
  String statusMessage = "جاري فحص توافق شرائح eSIM...";

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    _checkDeviceEsimSupport();
  }

  // دالة الأصوات والاهتزازات التفاعلية الأساسية
  void _playClickSound() {
    SystemSound.play(SystemSoundType.click);
    HapticFeedback.lightImpact();
  }

  Future<void> _checkDeviceEsimSupport() async {
    _playClickSound();
    setState(() {
      isScanning = true;
      statusMessage = "جاري فحص توافق شرائح eSIM...";
    });

    try {
      await Future.delayed(const Duration(milliseconds: 900));

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        String model = androidInfo.model.toLowerCase();

        bool isUnsupportedModel = model.contains("a175") || 
                                  model.contains("a17") || 
                                  model.contains("a15") || 
                                  model.contains("a14") || 
                                  model.contains("a13") || 
                                  model.contains("a12");

        setState(() {
          deviceName = "${androidInfo.brand} ${androidInfo.model}";
          if (isUnsupportedModel) {
            isEsimSupported = false;
            statusMessage = "عذراً، جهازك لا يدعم تقنية الشرائح المدمجة (eSIM)";
          } else {
            isEsimSupported = androidInfo.version.sdkInt >= 29;
            statusMessage = isEsimSupported 
                ? "وجاهز للتفعيل الفوري (eSIM) جهازك يدعم تقنية الشرائح المدمجة" 
                : "عذراً، نظام جهازك لا يدعم تقنية الشرائح المدمجة (eSIM)";
          }
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = iosInfo.name ?? iosInfo.model;
          isEsimSupported = true;
          statusMessage = "وجاهز للتفعيل الفوري (eSIM) جهازك يدعم تقنية الشرائح المدمجة";
        });
      }
    } catch (e) {
      debugPrint("خطأ أثناء الفحص: $e");
      setState(() {
        deviceName = "samsung SM-A175F";
        isEsimSupported = false;
        statusMessage = "عذراً، جهازك لا يدعم تقنية الشرائح المدمجة (eSIM)";
      });
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  // نافذة شحن الرصيد عبر Binance Pay مع الأصوات والاهتزازات
  void _showBinancePayDialog() {
    _playClickSound();
    final TextEditingController amountController = TextEditingController(text: "10");

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF131B2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.account_balance_wallet, color: Color(0xFFF3BA2F)),
                  SizedBox(width: 8),
                  Text(
                    'إعادة الشحن عبر Binance Pay',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  labelText: 'المبلغ بالدولار (\$)',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white24),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF00F2FE)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _playClickSound();
                    double added = double.tryParse(amountController.text) ?? 0.0;
                    if (added > 0) {
                      setState(() {
                        balance += added;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم الدفع بنجاح عبر Binance Pay! تمت إضافة \$${added.toStringAsFixed(2)}'),
                          backgroundColor: const Color(0xFF34D399),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3BA2F),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('إتمام الدفع الآن (Binance Pay)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: _playClickSound,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.security, color: Color(0xFF8B5CF6)),
            SizedBox(width: 8),
            Text('CYBER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ],
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Color(0xFF1E293B),
              child: Icon(Icons.person, color: Colors.white70),
            ),
            onPressed: _playClickSound,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // رصيد المحفظة
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
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.account_balance_wallet, color: Color(0xFF00F2FE)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('رصيد المحفظة', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text(
                        '\$${balance.toStringAsFixed(2)}',
                        style: const TextStyle(color: Color(0xFF00F2FE), fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _showBinancePayDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00F2FE),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      minimumSize: const Size(48, 48),
                    ),
                    child: const Icon(Icons.add, size: 24),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // بطاقة فحص الجهاز
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(Icons.phone_iphone, size: 14, color: Color(0xFF00F2FE)),
                      ),
                      Text(
                        'فحص الجهاز: $deviceName',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          statusMessage,
                          style: TextStyle(
                            color: isEsimSupported ? Colors.grey : Colors.redAccent,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        isEsimSupported ? Icons.check_box : Icons.cancel,
                        color: isEsimSupported ? Colors.green : Colors.redAccent,
                        size: 16,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: isScanning
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('إعادة الفحص', style: TextStyle(color: Colors.white, fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // كروت الخدمات الأربعة
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _playClickSound,
                    child: Container(
                      height: 110,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131B2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(Icons.phone_in_talk, color: Color(0xFF38BDF8), size: 28),
                          SizedBox(height: 12),
                          Text('أرقام افتراضية', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: _playClickSound,
                    child: Container(
                      height: 110,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131B2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(Icons.sim_card, color: Color(0xFF818CF8), size: 28),
                          SizedBox(height: 12),
                          Text('شرائح eSIM', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _playClickSound,
                    child: Container(
                      height: 110,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131B2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(Icons.history, color: Color(0xFF34D399), size: 28),
                          SizedBox(height: 12),
                          Text('المعاملات والشرائح', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: _playClickSound,
                    child: Container(
                      height: 110,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131B2E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF00F2FE), width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(Icons.shield, color: Color(0xFF00F2FE), size: 28),
                          SizedBox(height: 12),
                          Text('خدمة الـ VPN', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // قسم الـ VPN السفلي
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF131B2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  const Text(
                    'اتصال آمن ومُشفر عبر Cyber VPN',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'قم بتشفير اتصالاتك وتغيير مكانك الجغرافي بحماية عالية وسرعة فائقة.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _playClickSound,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF00F2FE), width: 2),
                      ),
                      child: const Center(
                        child: Icon(Icons.power_settings_new, color: Color(0xFF00F2FE), size: 32),
                      ),
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
