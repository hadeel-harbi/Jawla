import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

addActivityResponse(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());
    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase;
    final activities = supabase.from("activities");
    final activityDuration = supabase.from("activity_duration");
    final activityPictures = supabase.from("activity_pictures");

    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    final ownerId = (await supabase
        .from("owners")
        .select("id")
        .eq("user_id", userId))[0]["id"];

    final activityId = (await supabase
        .from("activities")
        .select("id")
        .eq("owner_id", ownerId))[0]["id"];

    // Insert activity info to "activities" table
    await activities.insert({
      "activity_name": body["activity_name"],
      "activity_price": body["activity_price"],
      "activity_location": body["activity_location"],
      "activity_description": body["activity_description"],
      "activity_pic": body["activity_pic"],
      "owner_id": ownerId,
    });

    // Insert activity duration to "activity_duration" table
    await activityDuration.insert({
      "activity_start_time": body["activity_start_time"],
      "activity_end_time": body["activity_end_time"],
      "activity_id": activityId,
    });

    // Insert activity pictures to "activity_pictures" table
    await activityPictures.insert({
      "picture_url": body["picture_url"],
      "activity_id": activityId,
    });

    return ResponseMsg().successResponse(
      msg: "add Activity success",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
