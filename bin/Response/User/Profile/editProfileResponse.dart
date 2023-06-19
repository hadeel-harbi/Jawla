import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../../RespnseMsg/ResponseMsg.dart';
import '../../../Services/Supabase/supabaseEnv.dart';

editProfileResponse(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());

    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase.from("users");

    if (body.keys.contains("name")) {
      await supabase.update(body).eq("id_auth", jwt.payload["sub"]);
      print("updated");
    }

    return ResponseMsg().successResponse(
      msg: "Your profile is updated",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
