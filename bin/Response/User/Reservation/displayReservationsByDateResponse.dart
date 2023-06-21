import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

displayReservationsByDateResponse(Request req, String date) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    // get user Id from (users) table
    final activitiesId = (await supabase
        .from("activity_duration")
        .select("activity_id")
        .eq("activity_date", date));
    print(activitiesId);
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    final activitiesIDList = [];
    for (var element in activitiesId) {
      List activitiesIdOfUser = (await supabase
          .from("reservations")
          .select("activity_id")
          .eq("user_id", userId)
          .eq("activity_id", element["activity_id"]));
      print(activitiesIdOfUser);
      if (activitiesIdOfUser.isNotEmpty) {
        activitiesIDList.add(activitiesIdOfUser);
      }
    }
    print(activitiesIDList);
    final activitiesList = [];

    for (var element in activitiesIDList) {
      final activity = (await supabase
          .from("activities")
          .select(
              "id, activity_name, activity_price, activity_city, activity_description, activity_pic, activity_duration(activity_date,activity_start_time,activity_end_time)")
          .eq("id", element[0]["activity_id"]))[0];

      activitiesList.add(activity);
    }

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"data": activitiesList},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
