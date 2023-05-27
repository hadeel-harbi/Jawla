import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

deleteFavoriteActivityResponse(Request req, String activityId) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload['sub']))[0]["id"];

    // delete favorite from (favorites) table
    await supabase
        .from("favorite")
        .delete()
        .match({"user_id": userId, "activity_id": int.parse(activityId)});

    return ResponseMsg().successResponse(
      msg: "Your favorite activity has been deleted",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
