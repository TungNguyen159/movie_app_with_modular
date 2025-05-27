import 'package:flutter/material.dart';
import 'package:movie_app2/core/theme/gap.dart';
import 'package:movie_app2/features/Search/widgets/search_box.dart';
import 'package:movie_app2/features/manage/widget/user_list_item.dart';
import 'package:movie_app2/service/user_service.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode(); // Tạo FocusNode để quản lý focus
  final userService = UserService();


  // Lựa chọn status để lọc
  String selectedStatus = 'Tất cả';

  void _onSearchChanged(String value) {
    setState(() {});
  }

  // Hàm thay đổi status để lọc
  void _onStatusChanged(String? value) {
    setState(() {
      selectedStatus = value ?? 'Tất cả';
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchBox(
                    controller: searchController,
                    focusNode: searchFocusNode,
                    onChanged: _onSearchChanged,
                  ),
                ),
                Gap.smWidth,
                DropdownButton<String>(
                  value: selectedStatus,
                  items: ['Tất cả', 'customer', 'staff', 'admin'].map((status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: _onStatusChanged,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder(
                stream: userService.stream,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Lỗi: ${snapshot.error}"));
                  }
                  final query = searchController.text.toLowerCase();
                  final filteredusers = snapshot.data!.where((user) {
                    final name = user.name.toLowerCase();
                    final userRole = user.role?.toLowerCase() ?? "";
                    // Lọc theo bookingid và status
                    final matchusername = name.contains(query);
                    final matchStatus = selectedStatus == 'Tất cả' ||
                        userRole.contains(selectedStatus.toLowerCase());

                    return matchusername && matchStatus;
                  }).toList();
                  return UserItem(user: filteredusers);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
