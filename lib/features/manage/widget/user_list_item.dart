import 'package:flutter/material.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/models/user.dart';
import 'package:movie_app2/service/user_service.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    this.user,
  });
  final List<Users>? user;
  @override
  Widget build(BuildContext context) {
    final userService = UserService();

    onDelete(Users id) async {
      final result = await showDialog(
        context: context,
        builder: (BuildContext context) => const CustomAlertDialog(
          title: "Alert",
          description: "do you want delete this user?",
          confirmText: "yes",
          cancelText: "no",
        ),
      );
      if (result == true) {
        await userService.deleteUser(id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("delete successful!.")),
        );
      } else {
        Navigator.of(context).pop;
      }
    }

    oneditUser(BuildContext context, Users user) {
      String selectedRole = user.role!;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Chỉnh sửa quyền"),
          content: DropdownButtonFormField<String>(
            value: selectedRole,
            items: ["staff", "customer"].map((role) {
              return DropdownMenuItem(
                  value: role, child: Text(role.toUpperCase()));
            }).toList(),
            onChanged: (value) => selectedRole = value!,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Hủy")),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                userService.updateUser(selectedRole, user);
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

    oneditStatus(BuildContext context, Users user) {
      String selectedStatus = user.status!;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Chỉnh sửa quyền"),
          content: DropdownButtonFormField<String>(
            value: selectedStatus,
            items: ["active", "banned"].map((role) {
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
                userService.updateStatus(selectedStatus, user);
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

    return ListView.builder(
      itemCount: user!.length,
      itemBuilder: (ctx, index) {
        final users = user![index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thông tin người dùng (Hàng ngang)
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueGrey[100],
                      radius: 30,
                      child: Text(
                        users.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 12), // Khoảng cách giữa avatar và thông tin
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            users.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(users.email!,
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                    // Trạng thái người dùng
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: users.status == "active"
                            ? Colors.green[100]
                            : Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        users.status!.toUpperCase(),
                        style: TextStyle(
                          color: users.status == "active"
                              ? Colors.green[700]
                              : Colors.red[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 10), // Khoảng cách giữa thông tin và nút bấm

                // Hàng chứa Role + Nút bấm
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Vai trò người dùng
                    Text(
                      "Role: ${users.role!.toUpperCase()}",
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Các nút bấm
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => oneditUser(ctx, users),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        IconButton(
                          onPressed: () => oneditStatus(ctx, users),
                          icon:
                              const Icon(Icons.settings, color: Colors.orange),
                        ),
                        IconButton(
                          onPressed: () => onDelete(users),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
