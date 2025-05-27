import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/models/chat.dart';
import 'package:movie_app2/service/chat_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatService = ChatService();
  final TextEditingController _controller = TextEditingController();
  late String roomid;
  late String userid;
  late String name;
  @override
  void initState() {
    super.initState();
    roomid = Modular.args.data["roomid"];
    userid = Modular.args.data["userid"];
    name = Modular.args.data["name"];
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    await chatService.sendMessage(Messages(
      roomid: roomid,
      senderId: userid,
      sendername: name,
      message: text,
    ));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trò chuyện với khách")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Messages>>(
              stream: chatService.subscribeMessages(roomid),
              builder: (context, snapshot) {
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[messages.length - 1 - index];
                    final isMe = msg.senderId == userid;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          if (!isMe) // Chỉ hiển thị tên nếu không phải mình
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                msg.sendername ?? "Unknown",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  isMe ? Colors.green[200] : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(msg.message,style: TextStyle(color: Colors.black),),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: "Nhập tin nhắn..."),
                    textInputAction: TextInputAction.done,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
