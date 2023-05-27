import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

editActivityResponse(Request req, String activityId) async {
  try {
    final Map body = jsonDecode(await req.readAsString());
    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase;

    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    final ownerId = (await supabase
        .from("owners")
        .select("id")
        .eq("user_id", userId))[0]["id"];

    // Update activity info in "activities" table
    await supabase.from("activities").update({
      "activity_name": body["activity_name"],
      "activity_price": body["activity_price"],
      "activity_location": body["activity_location"],
      "activity_description": body["activity_description"],
      "activity_pic": body["activity_pic"],
      "owner_id": ownerId,
    }).eq("id", int.parse(activityId));

    // Update activity duration in "activity_duration" table
    await supabase.from("activity_duration").update({
      "activity_start_time": body["activity_start_time"],
      "activity_end_time": body["activity_end_time"],
      "activity_date": body["activity_date"],
      "activity_id": activityId,
    }).eq("activity_id", int.parse(activityId));

    // Update activity pictures in "activity_pictures" table
    await supabase.from("activity_pictures").update({
      "picture_url": body["picture_url"],
      "activity_id": activityId,
    }).eq("activity_id", int.parse(activityId));

    return ResponseMsg().successResponse(
      msg: "Update Activity success",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
