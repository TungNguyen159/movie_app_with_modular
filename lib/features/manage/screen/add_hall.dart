import 'package:flutter/material.dart';
import 'package:movie_app2/models/hall.dart';
import 'package:movie_app2/service/hall_service.dart';

class AddHall extends StatefulWidget {
  const AddHall({super.key, this.hall});
  final Hall? hall; // Nhận dữ liệu Hall nếu chỉnh sửa

  @override
  State<AddHall> createState() => _AddHallState();
}

class _AddHallState extends State<AddHall> {
  final hallService = HallService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rowController = TextEditingController();
  final TextEditingController _columnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.hall != null) {
      // Nếu đang chỉnh sửa, đổ dữ liệu cũ vào các ô nhập
      _nameController.text = widget.hall!.nameHall;
      _rowController.text = widget.hall!.row.toString();
      _columnController.text = widget.hall!.column.toString();
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final int row = int.tryParse(_rowController.text) ?? 0;
    final int column = int.tryParse(_columnController.text) ?? 0;
    if (row <= 0 || column <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Số ghế hoặc giá vé không hợp lệ!")),
      );
      return;
    }
    try {
      if (widget.hall == null) {
        //  add Hall
        await hallService.insertHall(
            Hall(nameHall: _nameController.text, row: row, column: column));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hall added successfully!")),
        );
      } else {
        // update  Hall
        await hallService.updateHall(Hall(
          hallid: widget.hall!.hallid, // Giữ nguyên ID cũ
          nameHall: _nameController.text,
          row: row,
          column: column,
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Hall updated successfully!")),
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
    final isEditing = widget.hall != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Hall" : "Add Hall")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Hall Name"),
                validator: (value) => value!.isEmpty ? "Enter hall name" : null,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _rowController,
                decoration: const InputDecoration(labelText: "row"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter row" : null,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                controller: _columnController,
                decoration: const InputDecoration(labelText: "column"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Enter column" : null,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? "Update Hall" : "Add Hall"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
