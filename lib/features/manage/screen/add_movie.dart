import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/models/genres.dart';
import 'package:movie_app2/models/movies.dart';
import 'package:movie_app2/service/genres_service.dart';
import 'package:movie_app2/service/movie_service.dart';
import 'dart:io';

class AddMoviePage extends StatefulWidget {
  const AddMoviePage({super.key, this.movie});
  final Movies? movie;
  @override
  State<AddMoviePage> createState() => _AddMoviePageState();
}

class _AddMoviePageState extends State<AddMoviePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  DateTime? _releaseDate;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final movieService = MovieService();
  final genresService = GenresService();
  String? imageUrl;
  final _formKey = GlobalKey<FormState>();
  String? selectedGenre;
  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      // Nếu có dữ liệu cũ, hiển thị trước
      selectedGenre = widget.movie!.genreid;
      _titleController.text = widget.movie!.title;
      _descriptionController.text = widget.movie!.description;
      _durationController.text = widget.movie!.duration.toString();
      _ratingController.text = widget.movie!.average.toString();
      _releaseDate = DateTime.tryParse(widget.movie!.releasedate);
      imageUrl = widget.movie!.posterurl;
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _releaseDate = picked;
      });
    }
  }

  Future<void> _saveMovie() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Vui lòng nhập đầy đủ và chính xác thông tin")),
      );
      return;
    }
    if (_releaseDate == null || selectedGenre == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }
    if (_imageFile != null) {
      imageUrl = await movieService.uploadImage(_imageFile!);
    }
    final average = int.parse(_ratingController.text);
    final duration = int.parse(_durationController.text);
    if (widget.movie == null) {
      movieService.insertmovie(Movies(
        title: _titleController.text,
        genreid: selectedGenre,
        average: average,
        duration: duration,
        posterurl: imageUrl!,
        description: _descriptionController.text,
        releasedate: _releaseDate!.toIso8601String(),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Thêm phim thành công")),
      );
    } else {
      movieService.updateMovie(Movies(
        movieid: widget.movie!.movieid,
        genreid: selectedGenre,
        title: _titleController.text,
        average: average,
        duration: duration,
        posterurl: imageUrl!,
        description: _descriptionController.text,
        releasedate: _releaseDate!.toIso8601String(),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("cập nhật phim thành công")),
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thêm Phim")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: "Tiêu đề phim"),
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.isEmpty
                      ? "Không được để trống"
                      : null,
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: "Mô tả"),
                  maxLines: 3,
                  textInputAction: TextInputAction.next,
                  validator: (value) => value == null || value.isEmpty
                      ? "Không được để trống"
                      : null,
                ),
                TextFormField(
                  controller: _durationController,
                  decoration:
                      const InputDecoration(labelText: "Thời lượng (phút)"),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Không được để trống";
                    }
                    final parsed = int.tryParse(value);
                    return (parsed == null || parsed <= 0)
                        ? "Thời lượng phải là số dương"
                        : null;
                  },
                ),
                FutureBuilder<List<Genres>>(
                  future: genresService.getGenres(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("Không có thể loại nào.");
                    }

                    final genres = snapshot.data!;
                    return DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: "Selected Genres"),
                      value: selectedGenre,
                      items: genres.map((genre) {
                        return DropdownMenuItem(
                          value: genre.id,
                          child: Text("${genre.name} "),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGenre = value!;
                        });
                      },
                    );
                  },
                ),
                TextFormField(
                  controller: _ratingController,
                  decoration: const InputDecoration(
                      labelText: "Điểm trung bình (0-10)"),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Không được để trống";
                    }
                    final parsed = double.tryParse(value);
                    return (parsed == null || parsed < 0 || parsed > 10)
                        ? "Điểm phải từ 0 đến 10"
                        : null;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(_releaseDate == null
                        ? "Chọn ngày phát hành"
                        : DateFormat('dd/MM/yyyy').format(_releaseDate!)),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: _pickDate, child: const Text("Chọn")),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      _imageFile == null
                          ? const Text("Chưa chọn ảnh")
                          : Image.file(_imageFile!, height: 150),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text("Chọn Ảnh Poster"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveMovie();
                      }
                    },
                    child: const Text("Lưu Phim"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
