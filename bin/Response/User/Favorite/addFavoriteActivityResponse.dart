import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

addFavoriteActivityResponse(Request req, String activityId) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;
    final fromFavorite = supabase.from("favorite");

    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload['sub']))[0]["id"];

    List check = await fromFavorite
        .select("user_id, activity_id")
        .match({"user_id": userId, "activity_id": int.parse(activityId)});

    if (check.isEmpty) {
      await fromFavorite
          .insert({"user_id": userId, "activity_id": int.parse(activityId)});
    } else {
      await fromFavorite
          .delete()
          .match({"user_id": userId, "activity_id": int.parse(activityId)});
    }

    return ResponseMsg().successResponse(
      msg: "Your favorite activity has been added",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
