import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

verifyAccountResponse(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    // check if email and otp are not emtpy
    if (body["email"] == null || body["otp"] == null) {
      return ResponseMsg().errorResponse(
        msg: "please enter your email and OTP code",
      );
    }

    await SupabaseEnv().supabase.auth.verifyOTP(
          token: body["otp"],
          type: OtpType.signup,
          email: body["email"],
        );

    return ResponseMsg().successResponse(msg: "Your account is confirm");
  } catch (e) {
    return ResponseMsg().errorResponse(msg: "Not confirm! Try again");
  }
}
