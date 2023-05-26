import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayReservationsResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    // get user Id from (users) table
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    // get activity Id from (reservations) table
    final activitiesId = (await supabase
        .from("reservations")
        .select("activity_id")
        .eq("user_id", userId));

    final activitiesList = [];

    for (var element in activitiesId) {
      final activity = (await supabase
          .from("activities")
          .select("activity_name")
          .eq("id", element["activity_id"]))[0]["activity_name"];

      activitiesList.add(activity);
    }

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"Your activities:": activitiesList},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
