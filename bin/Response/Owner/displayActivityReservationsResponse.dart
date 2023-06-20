import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

displayActivityReservationsResponse(Request _, String activityId) async {
  try {
    final supabase = SupabaseEnv().supabase;

    // get activity Id from (reservations) table
    final List reservations = await supabase
        .from("reservations")
        .select()
        .eq("activity_id", int.parse(activityId));
    print(reservations);
    print(reservations.length);

    return ResponseMsg().successResponse(
      msg: "success",
      data: {
        "data": reservations.length,
      },
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
