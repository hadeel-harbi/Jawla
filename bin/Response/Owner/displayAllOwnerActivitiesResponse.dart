import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayAllOwnerActivitiesResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    // get user Id from (users) table
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    // get owner Id from (owners) table
    final ownerId = (await supabase
        .from("owners")
        .select("id")
        .eq("user_id", userId))[0]["id"];

    // display all activities created by owner
    final activitiesOwner = await supabase
        .from("activities")
        .select(
            "id, activity_name, activity_price, activity_city, activity_description, activity_pic, activity_duration(activity_date,activity_start_time,activity_end_time)")
        .eq("owner_id", ownerId);

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"data": activitiesOwner},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "$error");
  }
}
