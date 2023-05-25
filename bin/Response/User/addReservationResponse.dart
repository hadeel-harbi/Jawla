import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

addReservationResponse(Request req, String activityId) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    // get user Id from (users) table
    final user = await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    final userId = user[0]["id"];

    // get currnet date and time
    DateTime dateNow = DateTime.now();

    // insert new reservation
    await supabase.from("reservations").insert({
      "user_id": userId,
      "activity_id": int.parse(activityId),
      "reservation_time": dateNow.toString(),
    });

    //insert in activity_reservations table *****

    return ResponseMsg().successResponse(
      msg: "Your reservation has been complated successfully",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
