import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/Components/alert_dialog.dart';
import 'package:movie_app2/models/chat.dart';
import 'package:movie_app2/service/chat_service.dart';

class ChatUserList extends StatefulWidget {
  const ChatUserList({
    super.key,
  });
  @override
  State<ChatUserList> createState() => _ChatUserListState();
}

class _ChatUserListState extends State<ChatUserList> {
  final chatService = ChatService();
  List<Chatroom> _conversations = [];
  late String userid;
  late String name;
  @override
  void initState() {
    super.initState();
    userid = Modular.args.data["userid"];
    name = Modular.args.data["name"];
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final result = await chatService.getAllConversation();
    setState(() {
      _conversations = result;
    });
  }

  onDelete(String roomid) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => const CustomAlertDialog(
        title: "Xác nhận",
        description: "Bạn có chắc chắn muốn xóa chat này?",
        confirmText: "Có",
        cancelText: "Không",
      ),
    );
    if (result == true) {
      await chatService.deletemess(roomid);
      await chatService.deleteconvor(roomid);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Xóa thành công!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Khách hàng đang hỗ trợ")),
      body: RefreshIndicator(
        onRefresh: _loadConversations,
        child: ListView.builder(
          itemCount: _conversations.length,
          itemBuilder: (context, index) {
            final convo = _conversations[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(convo.user!.name),
                subtitle: Text(convo.user!.email!),
                onTap: () {
                  Modular.to.pushNamed("/manage/chatlist/chat", arguments: {
                    "roomid": convo.id,
                    "userid": userid,
                    "name": name,
                  });
                },
                trailing: IconButton(
                    onPressed: () async {
                      await onDelete(convo.id!);
                      _loadConversations();
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
