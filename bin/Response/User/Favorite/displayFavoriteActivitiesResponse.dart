import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

displayFavoriteActivitiesResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload['sub']))[0]["id"];

    // insert new favorite in (favorites) table
    final activityId = await supabase
        .from("favorite")
        .select("activity_id")
        .eq("user_id", userId);

    return ResponseMsg().successResponse(msg: "success", data: {
      "Your favorite : ": activityId,
    });
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
