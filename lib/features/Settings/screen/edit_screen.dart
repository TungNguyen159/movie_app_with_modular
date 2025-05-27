import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:movie_app2/Components/back_button.dart';
import 'package:movie_app2/Components/app_button.dart';
import 'package:movie_app2/models/user.dart';
import 'package:movie_app2/service/user_service.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final userService = UserService();

  late Users user;
  File? _imageFile;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    user = Modular.args.data["user"];
    _nameController.text = user.name;
    _emailController.text = user.email!;
    _ageController.text = user.age?.toString() ?? '';
    imageUrl = user.imageurl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // Mở hộp thoại chọn ảnh
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() => _imageFile = File(pickedFile.path));
    }
    Modular.to.pop(); // Đóng hộp thoại chọn ảnh
  }

  // Hiển thị hộp thoại chọn ảnh từ Camera hoặc Gallery
  Future<void> _showImagePickerDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn nguồn ảnh'),
          content: const Text('Bạn muốn lấy ảnh từ đâu?'),
          actions: [
            TextButton(
              child: const Text('📷 Camera'),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            TextButton(
              child: const Text('🖼️ Gallery'),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }

  // Lưu thay đổi
  void _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      if (_imageFile != null) {
        imageUrl = await userService.uploadImage(_imageFile!);
      }
      // Chỉ kiểm tra username nếu nó đã bị thay đổi
      if (_nameController.text != user.name) {
        final nameExists =
            await userService.isUsernameExists(_nameController.text);
        if (nameExists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "Username đã được sử dụng! Vui lòng chọn username khác."),
            ),
          );
          return;
        }
      }
   

      // Cập nhật thông tin user vào database
      await userService.updateCurrentuser(Users(
        id: user.id,
        name: _nameController.text,
        age: int.parse(_ageController.text),
        imageurl: imageUrl,
      ));
      Modular.to.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Thông tin đã được cập nhật!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa hồ sơ'),
        leading: BackBind(onPressed: () => Modular.to.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ảnh đại diện
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!) as ImageProvider
                        : (imageUrl != null && imageUrl!.isNotEmpty
                            ? NetworkImage(imageUrl!)
                            : const AssetImage("assets/no_image.png")
                                as ImageProvider),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt,
                        color: Colors.blue, size: 28),
                    onPressed: () => _showImagePickerDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Ô nhập tên
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              const SizedBox(height: 16),

              // Ô nhập tuổi
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Tuổi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tuổi';
                  }
                  if (int.tryParse(value) == null || int.tryParse(value)! < 0) return 'Tuổi không hợp lệ';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Ô email (chỉ đọc)
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 24),

              // Nút lưu thay đổi
              AppButton(
                onPressed: _saveProfile,
                text: "Lưu thay đổi",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
