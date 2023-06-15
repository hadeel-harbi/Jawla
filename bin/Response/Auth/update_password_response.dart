import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

updatePasswordResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final auth = SupabaseEnv().supabase.auth;

    final user = await auth.verifyOTP(
      token: body["code"],
      type: OtpType.recovery,
      email: body["email"],
    );
    if (user.session?.accessToken == null) {
      return Response.forbidden("sorry!");
    }
    await auth.updateUser(
      UserAttributes(email: body["email"], password: body["password"]),
    );

    return ResponseMsg().successResponse(
      msg: "password is updated",
    );
  } on AuthException catch (e) {
    return ResponseMsg().errorResponse(
      msg: "sorry error ! ${e.message} ",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(
      msg: "sorry error!!! $error ",
    );
  }
}
