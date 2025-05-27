import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie_app2/models/chat.dart';
import 'package:movie_app2/service/chat_service.dart';

class CustomerChatPage extends StatefulWidget {
  const CustomerChatPage({super.key});

  @override
  State<CustomerChatPage> createState() => _CustomerChatPageState();
}

class _CustomerChatPageState extends State<CustomerChatPage> {
  final chatService = ChatService();
  final TextEditingController _controller = TextEditingController();

  String? conversationId;
  late String customerid;
  late String sendername;
  @override
  void initState() {
    super.initState();
    customerid = Modular.args.data["customerid"];
    sendername = Modular.args.data["sendername"];
    _initConversation();
  }

  void _initConversation() async {
    final convoId = await chatService.getOrCreateConversation(customerid);
    setState(() {
      conversationId = convoId;
    });
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty || conversationId == null) return;

    await chatService.sendMessage(Messages(
      roomid: conversationId,
      senderId: customerid,
      sendername: sendername,
      message: text,
    ));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (conversationId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Hỗ trợ khách hàng")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Messages>>(
              stream:
                  chatService.subscribeMessages(conversationId!), // truyền vào
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("Không có dữ liệu "));
                }
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[messages.length - 1 - index];
                    final isMe = msg.senderId == customerid;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue[200] : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(msg.message),
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
