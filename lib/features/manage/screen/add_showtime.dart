import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app2/Components/app_button.dart';
import 'package:movie_app2/Components/list_display.dart';
import 'package:movie_app2/Components/text_head.dart';
import 'package:movie_app2/features/Search/widgets/search_box.dart';
import 'package:movie_app2/models/hall.dart';
import 'package:movie_app2/models/movies.dart';
import 'package:movie_app2/models/showtime.dart';
import 'package:movie_app2/service/hall_service.dart';
import 'package:movie_app2/service/movie_service.dart';
import 'package:movie_app2/service/showtime_service.dart';

class AddShowtimeScreen extends StatefulWidget {
  const AddShowtimeScreen({super.key, this.showtime});
  final Showtime? showtime;
  @override
  State<AddShowtimeScreen> createState() => _AddShowtimeScreenState();
}

class _AddShowtimeScreenState extends State<AddShowtimeScreen> {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final searchFocusNode = FocusNode();
  String? selectedMovieId;
  String? selectedRoom;
  String? selectedSTime;
  String? selectedETime;
  DateTime? selectedDate;
  final hallService = HallService();
  final movieService = MovieService();
  final showtimeService = ShowtimeService();
  Future<List<Movies>> searchInfo = Future.value([]);
  void _search(String value) {
    value = value.toLowerCase();
    setState(() {
      searchInfo = movieService.searchMovie(value);
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.showtime != null) {
      // Nếu có dữ liệu cũ, hiển thị trước
      selectedMovieId = widget.showtime!.movieid;
      selectedRoom = widget.showtime!.hallid;
      selectedSTime = widget.showtime!.starttime;
      selectedETime = widget.showtime!.endtime;
      selectedDate = widget.showtime!.date;
      priceController.text = widget.showtime!.price.toString();
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _pickstartTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedSTime =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  void _pickendTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedETime =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  void _saveShowtime() async {
    try {
      if (selectedMovieId == null ||
          selectedRoom == null ||
          selectedSTime == null ||
          selectedETime == null ||
          priceController.text.isEmpty ||
          selectedDate == null) {
        // thêm check selectedDate
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
        );
        return;
      }
      final format = DateFormat("HH:mm");

      DateTime startTime = format.parse(selectedSTime!);
      DateTime endTime = format.parse(selectedETime!);

      if (endTime.isBefore(startTime) || endTime.isAtSameMomentAs(startTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Giờ kết thúc phải sau giờ bắt đầu")),
        );
        return;
      }
      final int price = int.tryParse(priceController.text) ?? 0;
      if (price <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Giá vé không được nhỏ hơn 0 ")),
        );
        return;
      }
      bool isAvailable = true;

      if (widget.showtime == null ||
          selectedSTime != widget.showtime!.starttime ||
          selectedETime != widget.showtime!.endtime) {
        isAvailable = await showtimeService.isShowtimeAvailable(
            selectedRoom!, selectedSTime!, selectedETime!, selectedDate!);
      }

      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  "Thời gian suất chiếu bị trùng! Vui lòng chọn thời gian khác.")),
        );
        return;
      }

      final showtimes = Showtime(
        movieid: selectedMovieId!,
        hallid: selectedRoom,
        starttime: startTime.toString(),
        endtime: endTime.toString(),
        price: price,
        date: selectedDate!,
      );

      final newShowtimes = Showtime(
        showtimeid: widget.showtime?.showtimeid,
        movieid: selectedMovieId!,
        hallid: selectedRoom,
        starttime: selectedSTime!,
        endtime: selectedETime!,
        price: price,
        date: selectedDate!,
      );

      if (widget.showtime == null) {
        await showtimeService.insertShowtime(showtimes);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thêm suất chiếu thành công!")),
        );
      } else {
        await showtimeService.updateShowtime(newShowtimes);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cập nhật suất chiếu thành công!")),
        );
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Có lỗi xảy ra, vui lòng thử lại!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thêm suất chiếu")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBox(
                controller: searchController,
                focusNode: searchFocusNode,
                onChanged: _search,
              ),
              const SizedBox(height: 10),
              ListDisplay<Movies>(
                listFuture: searchInfo,
                builder: (snapshot) {
                  if (snapshot.isEmpty) {
                    return Center(
                      child: TextHead(
                        text: "Không có dữ liệu",
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return Wrap(
                    children: snapshot.map((movie) {
                      return ChoiceChip(
                        label: Text(movie.title),
                        selected: selectedMovieId == movie.movieid,
                        onSelected: (selected) {
                          setState(() {
                            selectedMovieId = selected ? movie.movieid : null;
                          });
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Hall>>(
                future: hallService.gethall(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("Không có phòng nào.");
                  }

                  final rooms = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: "Selected room"),
                    value: selectedRoom,
                    items: rooms.map((room) {
                      return DropdownMenuItem(
                        value: room.hallid,
                        child: Text("${room.nameHall} - ${room.status}"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      final selectedHall = rooms.firstWhere(
                        (hall) => hall.hallid == value,
                      );
                      if (selectedHall.status == "closed") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Phòng đã bị đóng vui lòng chọn phòng khác!")),
                        );
                      } else {
                        setState(() {
                          selectedRoom = value!;
                        });
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(selectedSTime == null
                      ? "Chọn giờ chiếu"
                      : selectedSTime!),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: _pickstartTime, child: const Text("Chọn")),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(selectedETime == null
                      ? "Chọn giờ kết thúc"
                      : selectedETime!),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: _pickendTime, child: const Text("Chọn")),
                ],
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Giá vé"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Nhập giá vé" : null,
              ),
              ListTile(
                title: Text(selectedDate == null
                    ? 'Chọn ngày chiếu'
                    : 'Ngày: ${DateFormat('dd/MM/yyyy').format(selectedDate!.toLocal())}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() => selectedDate = pickedDate);
                  }
                },
              ),
              const SizedBox(height: 20),
              AppButton(
                text: widget.showtime == null ? 'Thêm' : 'Lưu chỉnh sửa',
                onPressed: _saveShowtime,
              )
            ],
          ),
        ),
      ),
    );
  }
}
