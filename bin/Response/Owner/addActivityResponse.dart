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
    final supabaseFromActivities = supabase.from("activities");

    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    final ownerId = (await supabase
        .from("owners")
        .select("id")
        .eq("user_id", userId))[0]["id"];

    // insert new activity
    await supabaseFromActivities.insert({
      "activity_name": body["activity_name"],
      "activity_price": body["activity_price"],
      "activity_city": body["activity_city"],
      "activity_description": body["activity_description"],
      "owner_id": ownerId,
    });

    final activityId = (await supabaseFromActivities
        .select("id")
        .eq("owner_id", ownerId)
        .order("id", ascending: false)
        .limit(1))[0]["id"];

    // Insert activity duration to "activity_duration" table
    await supabase.from("activity_duration").insert({
      "activity_start_time": body["activity_start_time"],
      "activity_end_time": body["activity_end_time"],
      "activity_date": body["activity_date"],
      "activity_id": activityId,
    });

    // Insert activity pictures to "activity_pictures" table
    await supabase.from("activity_pictures").insert({
      "picture_url": body["picture_url"],
      "activity_id": activityId,
    });

    return ResponseMsg().successResponse(
      msg: "add Activity success",
      data: {"activity Id : ": activityId},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
