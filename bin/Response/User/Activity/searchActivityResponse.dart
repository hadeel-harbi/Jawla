import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

searchActivitResponse(Request _, String text) async {
  try {
    final supabase = SupabaseEnv().supabase;

    final List results = [];

    final activities = await supabase
        .from('activities')
        .select()
        .textSearch('activity_name', "$text:*");
    print(activities); // List<dynamic>
    print("------");
    print(activities[0]["id"]);
    for (var element in activities) {
      // print(element); // Map<String, dynamic>

      final duration = await supabase
          .from('activity_duration')
          .select('activity_date,activity_start_time,activity_end_time')
          .eq("activity_id", activities[0]["id"]);
      print(duration);
      print("++++");
      results.add([element, duration]);
    }
    print(results);

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"data": results},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "$error");
  }
}
