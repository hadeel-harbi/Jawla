import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

displayActivityByIdResponse(Request _, String id) async {
  try {
    final supabase = SupabaseEnv().supabase;

    // display  activity by id
    final activity =
        (await supabase.from("activities").select().eq("id", int.parse(id)))[0];

    final activityDuration = (await supabase
        .from("activity_duration")
        .select("activity_date , activity_start_time , activity_end_time")
        .eq("activity_id", int.parse(id)))[0];

    final activityDetail = [activity, activityDuration];

    return ResponseMsg().successResponse(
      msg: "success",
      data: {" activity :": activityDetail},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "$error");
  }
}
