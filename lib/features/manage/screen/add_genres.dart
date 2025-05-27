import 'package:flutter/material.dart';
import 'package:movie_app2/models/genres.dart';
import 'package:movie_app2/service/genres_service.dart';

class AddGenres extends StatefulWidget {
  const AddGenres({super.key, this.genres});
  final Genres? genres;
  @override
  State<AddGenres> createState() => _AddGenresState();
}

class _AddGenresState extends State<AddGenres> {
  final genresService = GenresService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.genres != null) {
      // Nếu đang chỉnh sửa, đổ dữ liệu cũ vào các ô nhập
      _nameController.text = widget.genres!.name;
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (widget.genres == null) {
        //  add Hall
        await genresService.insertGenres(Genres(
          name: _nameController.text,
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Genres added successfully!")),
        );
      } else {
        // update  Hall
        await genresService.updateGenres(Genres(
          id: widget.genres!.id, // Giữ nguyên ID cũ
          name: _nameController.text,
        ));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Genres updated successfully!")),
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
    final isEditing = widget.genres != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Edit Genres" : "Add Genres")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Genres Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter Genres name" : null,
                textInputAction: TextInputAction.next,
              ),
            
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? "Update Genres" : "Add Genres"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
