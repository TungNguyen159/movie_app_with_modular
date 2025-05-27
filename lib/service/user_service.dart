import 'dart:io';

import 'package:movie_app2/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  final supabase = Supabase.instance.client;

  // get current user
  Future<Users?> getUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    final response = await supabase
        .from('users')
        .select()
        .eq('id', user.id)
        .single(); // Lấy 1 record duy nhất

    return Users.fromJson(response);
  }

  // getusserbyid
  Future<Users?> getUserbyid(String userid) async {
    final response = await supabase
        .from('users')
        .select()
        .eq('id', userid)
        .single(); // Lấy 1 record duy nhất

    return Users.fromJson(response);
  }

  //check username exists
  Future<bool> isUsernameExists(String username) async {
    final response =
        await supabase.from('users').select('id').eq('name', username);

    return response.isNotEmpty;
  }
  //check email exists
  Future<bool> isEmailExists(String email) async {
    final response =
        await supabase.from('users').select('id').eq('email', email);

    return response.isNotEmpty;
  }
  // read user realtime
  final stream = Supabase.instance.client.from('users').stream(
    primaryKey: ['id'],
  ).map((data) => data.map((e) => Users.fromJson(e)).toList());
  Stream<Users?> get streamUser {
    final currentUserId = supabase.auth.currentUser?.id;

    // Nếu chưa đăng nhập, trả về Stream rỗng
    if (currentUserId == null) {
      return Stream.value(null);
    }

    return supabase
        .from('users')
        .stream(primaryKey: ['id'])
        .eq('id', currentUserId)
        .limit(1)
        .map((data) => data.isNotEmpty ? Users.fromJson(data.first) : null);
  }

  // insert user signup
  Future<void> insertUserProfile(String name) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase.from('users').insert({
      'id': user.id,
      'email': user.email,
      'name': name,
      'role': "customer",
      'status': "active",
    });
  }

  //searchuser
  Future<void> searchuser(String query) async {
    await supabase.from('users').select().like("name", query).select();
  }

  // update user by id
  Future<void> updateUser(String newRole, Users user) async {
    await supabase
        .from('users')
        .update({
          'role': newRole,
        })
        .eq('id', user.id)
        .select();
  }

  // delete user by id
  Future<void> deleteUser(Users user) async {
    await supabase.from('users').delete().eq('id', user.id);
  }

  Future<String?> uploadImage(File imageFile) async {
    final imageName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    final response =
        await supabase.storage.from('image').upload(imageName, imageFile);
    if (response.isNotEmpty) {
      return supabase.storage.from('image').getPublicUrl(imageName);
    } else {
      return null;
    }
  }

  // update current user
  Future<void> updateCurrentuser(Users user) async {
    await supabase.from('users').update({
      'name': user.name,
      'age': user.age,
      'image_url': user.imageurl,
    }).eq('id', user.id);
  }

  // refresh token
  Future<void> refreshUserSession() async {
    final supabase = Supabase.instance.client;
    final session = await supabase.auth.refreshSession();

    if (session.session != null) {
      print(" Token mới: ${session.session!.accessToken}");
    } else {
      print("Không thể refresh session, có thể user đã đăng xuất.");
    }
  }

  // update status by id
  Future<void> updateStatus(String newStatus, Users user) async {
    await supabase
        .from('users')
        .update({
          'status': newStatus,
        })
        .eq('id', user.id)
        .select();
  }
}
