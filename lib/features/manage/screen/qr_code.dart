import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool _isScanning = true;

  void _onDetect(BarcodeCapture capture) {
    if (!_isScanning) return;

    final barcode = capture.barcodes.first;
    final String? rawValue = barcode.rawValue;

    if (rawValue != null) {
      setState(() {
        _isScanning = false;
      });

      // Xử lý dữ liệu QR ở đây
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Mã hoá đơn'),
          content: Text(rawValue),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Modular.to.pushNamed("/manage/bookdetail", arguments: {
                  "bookingid": rawValue,
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quét mã QR')),
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 350,
              width: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.noDuplicates,
                      facing: CameraFacing.back,
                      cameraResolution: const Size(200, 200)),
                  onDetect: _onDetect,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Đưa mã QR vào giữa khung',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
