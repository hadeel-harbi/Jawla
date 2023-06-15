import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

checkCodeResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final auth = SupabaseEnv().supabase.auth;

    if (body["code"] == null && body["email"] == null) {
      return Response.badRequest(body: "please enter the missing fields");
    }

    final user = await auth.verifyOTP(
      token: body["code"],
      type: OtpType.recovery,
      email: body["email"],
    );

    if (user.session?.accessToken == null) {
      return Response.forbidden("sorry!");
    }

    return ResponseMsg().successResponse(
      msg: "code is correct",
    );
  } on AuthException catch (e) {
    return ResponseMsg().errorResponse(
      msg: "sorry error ! ${e.message} ",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(
      msg: "sorry error ! $error ",
    );
  }
}
