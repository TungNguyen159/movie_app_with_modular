import 'package:flutter/material.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/features/manage/screen/add_hall.dart';
import 'package:movie_app2/models/hall.dart';
import 'package:movie_app2/service/hall_service.dart';

class HallListItem extends StatelessWidget {
  const HallListItem({super.key, required this.hall});
  final List<Hall> hall;

  @override
  Widget build(BuildContext context) {
    oneditStatus(BuildContext context, Hall hall) {
      String selectedStatus = hall.status!;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Chỉnh sửa trạng thái"),
          content: DropdownButtonFormField<String>(
            value: selectedStatus,
            items: ["active", "closed"].map((role) {
              return DropdownMenuItem(
                  value: role, child: Text(role.toUpperCase()));
            }).toList(),
            onChanged: (value) => selectedStatus = value!,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Hủy")),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                HallService().updateStatusHall(hall, selectedStatus);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("update successful!.")),
                );
              },
              child: const Text("Lưu"),
            ),
          ],
        ),
      );
    }

    onDelete(Hall hallid) async {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => const CustomAlertDialog(
          title: "Xác nhận",
          description: "Bạn có chắc chắn muốn xóa suất chiếu này?",
          confirmText: "Có",
          cancelText: "Không",
        ),
      );
      if (result == true) {
        await HallService().deleteHall(hallid);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Xóa thành công!")),
        );
      }
    }

    return ListView.builder(
      itemCount: hall.length,
      itemBuilder: (context, index) {
        final halls = hall[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            title: Text(
              halls.nameHall,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Số ghế: ${halls.row * halls.column}"),
                Text(
                  "Trạng thái: ${halls.status}",
                  style: TextStyle(
                    color:
                        (halls.status == "active") ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => oneditStatus(context, halls),
                  icon: const Icon(Icons.settings, color: Colors.orange),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddHall(hall: halls),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(halls),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
