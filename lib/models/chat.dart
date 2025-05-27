import 'package:movie_app2/models/user.dart';

class Chatroom {
  final String? id;
  final String customerid;
  final DateTime createdat;
  final Users? user;
  Chatroom(
      {required this.id,
      required this.customerid,
      required this.createdat,
      this.user});

  factory Chatroom.fromJson(Map<String, dynamic> json) {
    return Chatroom(
      id: json['id'].toString(),
      customerid: json['user_id'] ?? "no customer",
      createdat: DateTime.parse(json['created_at']),
      user: json['users'] != null ? Users.fromJson(json['users']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': customerid,
      'created_at': createdat.toIso8601String(),
    };
  }
}

class Messages {
  final String? id;
  final String? roomid;
  final String? senderId;
  final String? sendername;
  final String message;
  final DateTime? timestamp;
  final Users? user;
  Messages(
      {this.id,
      this.roomid,
      required this.message,
      this.timestamp,
      this.senderId,
      this.sendername,
      this.user});

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages(
      id: json['id'].toString(),
      roomid: json['room_id'],
      senderId: json['sender_id'],
      sendername: json['sender_name'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      user: json['users'] != null ? Users.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_id': roomid,
      'sender_id': senderId,
      'sender_name': sendername,
      'message': message,
      'timestamp': timestamp!.toIso8601String(),
    };
  }
}
