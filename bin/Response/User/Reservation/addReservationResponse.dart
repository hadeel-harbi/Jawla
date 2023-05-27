import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

addReservationResponse(Request req, String activityId) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;
    final fromReservations = supabase.from("reservations");

    // get user Id from (users) table
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    // get currnet date and time
    DateTime dateNow = DateTime.now();

    // insert new reservation
    await fromReservations.insert({
      "user_id": userId,
      "activity_id": int.parse(activityId),
      "reservation_time": dateNow.toString(),
    });

    //---------

    final ownerId = (await supabase
        .from("activities")
        .select("owner_id")
        .eq("id", int.parse(activityId)))[0]["owner_id"];

    final reserId = (await fromReservations.select("id").eq(
          "activity_id",
          int.parse(activityId),
        ))[0]["id"];

    //insert in (activity_reservations) table *****
    await supabase.from("activity_reservations").insert({
      "owner_id": ownerId,
      "reservation_id": reserId,
      "activity_id": int.parse(activityId),
    });

    return ResponseMsg().successResponse(
      msg: "Your reservation has been complated successfully",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
