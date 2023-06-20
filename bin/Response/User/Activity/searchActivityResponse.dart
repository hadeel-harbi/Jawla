import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

searchActivitResponse(Request _, String text) async {
  try {
    final supabase = SupabaseEnv().supabase;

    final results = await supabase
        .from('activities')
        .select(
          'id, activity_name, activity_price, activity_city, activity_description, activity_pic, activity_duration(activity_date,activity_start_time,activity_end_time)',
        )
        .textSearch('activity_name', "$text:*");

    print(results);

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"data": results},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "$error");
  }
}
