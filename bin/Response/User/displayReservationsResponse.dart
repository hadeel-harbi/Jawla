import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayReservationsResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    // get user Id from (users) table
    final user = await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    final userId = user[0]["id"];

    // get activity Id from (reservations) table
    final activityId = (await supabase
        .from("reservations")
        .select("activity_id")
        .eq("user_id", userId))[0]["activity_id"];

    // display activities from (activities) table
    final activities = await supabase
        .from("activities")
        .select("activity_name")
        .eq("activity_id", activityId);

    print(activities);

    return ResponseMsg().successResponse(
      msg: "Your ractivities:",
      data: jsonDecode(activities.toString()),
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
