import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

displayAllActivitiesResponse(Request _) async {
  try {
    final supabase = SupabaseEnv().supabase;

    final activities = await supabase.from("activities").select(
          "id, activity_name, activity_price, activity_city, activity_description, activity_pic,person_number, activity_duration(activity_date,activity_start_time,activity_end_time)",
        );

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"data": activities},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "$error");
  }
}
