import 'package:movie_app2/models/hall.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HallService {
  final supabase = Supabase.instance.client;

  Future<List<Hall>> gethall() async {
    final response = await supabase.from('halls').select();
    if (response.isEmpty) {
      return [];
    }
    return response.map<Hall>((hall) => Hall.fromJson(hall)).toList();
  }

  // insert hall
  Future<void> insertHall(Hall hall) async {
    await supabase.from("halls").insert({
      "namehall": hall.nameHall,
      "row": hall.row,
      "column": hall.column,
      "status": "active",
    });
  }

  // stream hall
  final streamHall = Supabase.instance.client.from('halls').stream(
    primaryKey: ['id'],
  ).map((data) => data.map((e) => Hall.fromJson(e)).toList());
  // hall get by id
  Future<Hall> fetchHallById(String hallId) async {
    final response = await Supabase.instance.client
        .from('halls')
        .select('*')
        .eq('id', hallId)
        .single();
    return Hall.fromJson(response);
  }

  // update hall
  Future<void> updateHall(Hall hall) async {
    await supabase.from("halls").update({
      "namehall": hall.nameHall,
      "row": hall.row,
      "column": hall.column,
    }).eq("id", hall.hallid!);
  }

  // update status hall
  Future<void> updateStatusHall(Hall hall, String newStatus) async {
    await supabase.from("halls").update({
      "status": newStatus,
    }).eq("id", hall.hallid!);
  }

  // delete Hall by id
  Future<void> deleteHall(Hall hall) async {
    await supabase.from("halls").delete().eq("id", hall.hallid!);
  }
}
