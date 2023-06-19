import 'dart:convert';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

loginResponse(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    // check if user enter email and password
    if (body["email"] == null || body["password"] == null) {
      return ResponseMsg().errorResponse(
        msg: "Enter your email and password",
      );
    }

    //login
    final userLogin = await SupabaseEnv()
        .supabase
        .auth
        .signInWithPassword(email: body["email"], password: body["password"]);

    final token = userLogin.session!.accessToken.toString();

    // ------ success
    return ResponseMsg().successResponse(
      msg: "Log in",
      data: {
        "Token": token,
      },
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "Error log in, $error");
  }
}
