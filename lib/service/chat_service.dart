import 'package:movie_app2/models/chat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  final supabase = Supabase.instance.client;

  Future<String?> getOrCreateConversation(String customerId) async {
    final result = await supabase
        .from('conversations')
        .select()
        .eq('user_id', customerId)
        .maybeSingle();

    if (result != null) return result['id'];

    final inserted = await supabase
        .from('conversations')
        .insert({'user_id': customerId})
        .select()
        .single();

    return inserted['id'];
  }

  Future<void> sendMessage(Messages messages) async {
    await supabase.from('messages').insert({
      'room_id': messages.roomid,
      'sender_id': messages.senderId,
      'sender_name': messages.sendername,
      'message': messages.message,
    });
  }

  Stream<List<Messages>> subscribeMessages(String roomid) {
    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', roomid)
        .map((data) => data.map((e) => Messages.fromJson(e)).toList());
  }

  Future<List<Chatroom>> getAllConversation() async {
    final response =
        await supabase.from('conversations').select('*,users(name,email)');
    return response.map((e) => Chatroom.fromJson(e)).toList();
  }
  // delete conversations
  Future<void> deleteconvor(String roomid) async {
    await supabase.from("conversations").delete().eq("id", roomid);
  }// delete messages
  Future<void> deletemess(String roomid) async {
    await supabase.from("messages").delete().eq("room_id", roomid);
  }
}
