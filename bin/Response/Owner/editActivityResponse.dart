import 'dart:convert';  

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

editActivityResponse(Request req) async {
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

    // Get activity info from "activities" table
    final activityInfo = (await activities.select().eq("owner_id", ownerId))[0];

    // Get activity duration times from "activity_duration" table
    final activityDurationTimes =
        (await activityDuration.select().eq("activity_id", activityId))[0];

    // Get activity pictures from "activity_pictures" table
    final activityPicturesUrls =
        (await activityPictures.select().eq("activity_id", activityId))[0];

    // Update activity info in "activities" table
    await activities.update({
      "activity_name": body["activity_name"],
      "activity_price": body["activity_price"],
      "activity_location": body["activity_location"],
      "activity_description": body["activity_description"],
      "activity_pic": body["activity_pic"],
      "owner_id": ownerId,
    }).match({
      "activity_name": activityInfo["activity_name"],
      "activity_price": activityInfo["activity_price"],
      "activity_location": activityInfo["activity_location"],
      "activity_description": activityInfo["activity_description"],
      "activity_pic": activityInfo["activity_pic"],
    });

    // Update activity duration in "activity_duration" table
    await activityDuration.update({
      "activity_start_time": body["activity_start_time"],
      "activity_end_time": body["activity_end_time"],
      "activity_id": activityId,
    }).match({
      "activity_start_time": activityDurationTimes["activity_start_time"],
      "activity_end_time": activityDurationTimes["activity_end_time"],
    });

    // Update activity pictures in "activity_pictures" table
    await activityPictures.update({
      "picture_url": body["picture_url"],
      "activity_id": activityId,
    }).match({
      "picture_url": activityPicturesUrls["picture_url"],
    });

    return ResponseMsg().successResponse(
      msg: "Update Activity success",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
