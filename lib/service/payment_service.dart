import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/config/api_key.dart';
import 'package:movie_app2/models/payment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

//[VNPayHashType] List of Hash Type in VNPAY, default is HMACSHA512
enum VNPayHashType {
  SHA256,
  HMACSHA512,
}

//[BankCode] List of valid payment bank in VNPAY, if not provide, it will be manual select, default is null
enum BankCode { VNPAYQR, VNBANK, INTCARD }

//[VNPayHashTypeExt] Extension to convert from HashType Enum to valid string of VNPAY
extension VNPayHashTypeExt on VNPayHashType {
  String toValueString() {
    switch (this) {
      case VNPayHashType.SHA256:
        return 'SHA256';
      case VNPayHashType.HMACSHA512:
        return 'HmacSHA512';
    }
  }
}

//[VNPAYFlutter] instance class VNPAY Flutter
class VNPAYFlutter {
  final supabase = Supabase.instance.client;

  Future<void> insertpayment(Payment payment) async {
    await supabase.from("payments").insert({
      'payment_status': 'success',
      'booking_id': payment.bookingid,
      'vnp_transactionno': payment.vnptransactionNo,
      'vnp_transactiondate': payment.vnptransactiondate,
      'vnp_order_info': payment.vnporderInfo,
    });
  }

  Future<Payment?> getPaymentbyid(String bookingid) async {
    final response = await supabase
        .from("payments")
        .select()
        .eq("booking_id", bookingid)
        .single();

    return Payment.fromJson(response);
  }

  static final VNPAYFlutter _instance = VNPAYFlutter();

  //[instance] Single Ton Init
  static VNPAYFlutter get instance => _instance;

  Map<String, String> _sortParams(Map<String, String> params) {
    var sortedParams = Map<String, String>.fromEntries(
      params.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
    return sortedParams;
  }

  //[generatePaymentUrl] Generate payment Url with input parameters
  String url = 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html';
  String command = 'pay';
  String locale = 'vn';
  String currencyCode = 'VND';
  String vnpayOrderType = 'other';
  DateTime? createAt;
  VNPayHashType vnPayHashType = VNPayHashType.HMACSHA512;
  BankCode? bankCode;
  String ipAdress = '192.168.1.1';
  String vnpayHashKey = ApiKey.vnpHashSecret;
  String returnUrl = Uri.encodeFull("movieapp://payment-result");
  String version = '2.1.0';
  String tmnCode = ApiKey.vnptmnCode;
  DateTime vnpayExpireDate = DateTime.now().add(const Duration(minutes: 15));
  String generatePaymentUrl({
    required String txnRef,
    required int amount,
  }) {
    String orderInfo = 'Pay Order$txnRef';
    // Đảm bảo orderInfo và các trường khác không chứa ký tự đặc biệt
    final safeOrderInfo = Uri.encodeComponent(orderInfo);

    final params = <String, String>{
      'vnp_Version': version,
      'vnp_Command': command,
      'vnp_TmnCode': tmnCode,
      'vnp_Locale': locale,
      'vnp_CurrCode': currencyCode,
      'vnp_TxnRef': txnRef,
      'vnp_OrderInfo': safeOrderInfo,
      'vnp_Amount': (amount * 100).toString(),
      'vnp_ReturnUrl': returnUrl,
      'vnp_IpAddr': ipAdress,
      'vnp_CreateDate': DateFormat('yyyyMMddHHmmss')
          .format(createAt ?? DateTime.now())
          .toString(),
      'vnp_OrderType': vnpayOrderType,
      'vnp_ExpireDate':
          DateFormat('yyyyMMddHHmmss').format(vnpayExpireDate).toString(),
    };
    if (bankCode != null) {
      params['vnp_BankCode'] = bankCode!.name;
    }
    // Sắp xếp tham số
    var sortedParam = _sortParams(params);
    // Tạo chuỗi hash
    final hashDataBuffer = StringBuffer();
    sortedParam.forEach((key, value) {
      if (value.isNotEmpty) {
        // Loại bỏ tham số trống
        hashDataBuffer.write(key);
        hashDataBuffer.write('=');
        hashDataBuffer.write(Uri.encodeComponent(value)); // Mã hóa giá trị
        hashDataBuffer.write('&');
      }
    });
    String hashData =
        hashDataBuffer.toString().substring(0, hashDataBuffer.length - 1);
    // Tạo URL query không mã hóa URI component
    String query = sortedParam.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
        .join('&');
    // Tạo chữ ký
    String vnpSecureHash = Hmac(sha512, utf8.encode(vnpayHashKey))
        .convert(utf8.encode(hashData))
        .toString()
        .toUpperCase();

    String paymentUrl =
        "$url?$query&vnp_SecureHashType=${vnPayHashType.toValueString()}&vnp_SecureHash=$vnpSecureHash";

    // Log để debug
    debugPrint("=====>[PAYMENT URL]: $paymentUrl");
    return paymentUrl;
  }

  Future<void> show({
    required String paymentUrl,
    required BuildContext context,
    Function(Map<String, dynamic>)? onPaymentSuccess,
    Function(Map<String, dynamic>)? onPaymentError,
    Function()? onWebPaymentComplete,
  }) async {
    if (kIsWeb) {
      // Xử lý trên Web bằng cách mở URL trong trình duyệt
      await launchUrlString(
        paymentUrl,
        webOnlyWindowName: '_self',
      );
      if (onWebPaymentComplete != null) {
        onWebPaymentComplete();
      }
    } else {
      // Tạo WebViewController
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              final url = request.url;
              if (url.contains('vnp_ResponseCode')) {
                final params = Uri.parse(url).queryParameters;
                if (params['vnp_ResponseCode'] == '00') {
                  if (onPaymentSuccess != null) {
                    onPaymentSuccess(Map<String, dynamic>.from(params));
                  }
                } else {
                  if (onPaymentError != null) {
                    onPaymentError(Map<String, dynamic>.from(params));
                    Modular.to.pushNamed("/main/detail/ticket/confirm");
                  }
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onWebResourceError: (error) {
              print("❌ Lỗi WebView: ${error.description}");
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        )
        ..loadRequest(Uri.parse(paymentUrl));

      // Hiển thị WebView trong một dialog hoặc screen mới
      if (context.mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('VNPay Payment'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                    if (onPaymentError != null) {
                      onPaymentError({'vnp_ResponseCode': 'user_cancelled'});
                    }
                  },
                ),
              ),
              body: WebViewWidget(controller: controller),
            ),
          ),
        );
      }
    }
  }
}
