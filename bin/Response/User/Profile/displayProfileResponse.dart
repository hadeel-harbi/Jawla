import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

displayProfileResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase;

    final profile = (await supabase
        .from("users")
        .select("name , email , phone , city , profile_pic, is_owner")
        .eq("id_auth", jwt.payload["sub"]))[0];

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"data": profile},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
