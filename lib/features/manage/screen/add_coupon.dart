import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/models/coupon.dart';
import 'package:movie_app2/service/coupon_service.dart';

class AddCoupon extends StatefulWidget {
  const AddCoupon({super.key, this.coupon});
  final Coupon? coupon;
  @override
  State<AddCoupon> createState() => _AddCouponState();
}

class _AddCouponState extends State<AddCoupon> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _discountController = TextEditingController();
  bool _isPercentage = true;
  DateTime? _expiresAt;
  final couponService = CouponService();
  @override
  void initState() {
    super.initState();
    if (widget.coupon != null) {
      // Nếu đang chỉnh sửa, đổ dữ liệu cũ vào các ô nhập
      _codeController.text = widget.coupon!.code;
      _discountController.text = widget.coupon!.discount.toString();
      _isPercentage = widget.coupon!.ispercentage;
      _expiresAt = widget.coupon!.expiretime;
    }
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    final int discount = int.tryParse(_discountController.text) ?? 0;
    if (discount <= 0 || _expiresAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Số mã hoặc ngày không hợp lệ!")),
      );
      return;
    }
    try {
      if (widget.coupon == null) {
        //  add Hall
        await couponService.insertCoupon(Coupon(
            code: _codeController.text,
            discount: discount,
            expiretime: _expiresAt!,
            ispercentage: _isPercentage));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("coupon added successfully!")),
        );
      } else {
        // update  Hall
        await couponService.updateCoupon(Coupon(
          couponid: widget.coupon!.couponid,
          code: _codeController.text,
          discount: discount,
          expiretime: _expiresAt!,
          ispercentage: _isPercentage,
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("coupon updated successfully!")),
        );
      }

      Navigator.pop(context, true); // Trả về kết quả để cập nhật danh sách
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.coupon != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit coupon' : 'Thêm Coupon')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Mã giảm giá'),
                validator: (value) =>
                    value!.isEmpty ? 'Nhập mã giảm giá' : null,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: 'Giá trị giảm'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Nhập giá trị giảm' : null,
                textInputAction: TextInputAction.done,
              ),
              SwitchListTile(
                title: const Text('Giảm theo %'),
                value: _isPercentage,
                onChanged: (val) => setState(() => _isPercentage = val),
              ),
              ListTile(
                title: Text(_expiresAt == null
                    ? 'Chọn ngày hết hạn'
                    : 'Hết hạn: ${DateFormat('dd/MM/yyyy').format(_expiresAt!.toLocal())}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() => _expiresAt = pickedDate);
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(isEditing ? 'Update Coupon' : 'Add Coupon'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
