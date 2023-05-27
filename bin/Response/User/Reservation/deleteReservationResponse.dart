import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

deleteReservationResponse(Request req, String reserId) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    // get user Id from (users) table
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    // delete reservation from (reservations) table
    await supabase
        .from("reservations")
        .delete()
        .match({"id": int.parse(reserId), "user_id": userId});

    return ResponseMsg().successResponse(
      msg: "Delete reservation",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
