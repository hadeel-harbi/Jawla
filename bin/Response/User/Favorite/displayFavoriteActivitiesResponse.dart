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

    final activitiesList = [];

    for (var element in activityId) {
      final activity = (await supabase
          .from("activities")
          .select(
              "id, activity_name, activity_price, activity_city, activity_description, activity_pic, activity_duration(activity_date,activity_start_time,activity_end_time)")
          .eq("id", element["activity_id"]))[0];

      activitiesList.add(activity);
    }

    return ResponseMsg().successResponse(msg: "success", data: {
      "data": activitiesList,
    });
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
