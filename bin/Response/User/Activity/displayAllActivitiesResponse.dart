import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

displayAllActivitiesResponse(Request _) async {
  try {
    final supabase = SupabaseEnv().supabase;

    final activities = await supabase.from("activities").select();

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"the activities:": activities},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "$error");
  }
}
