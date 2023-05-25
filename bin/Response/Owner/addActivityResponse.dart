import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

addActivityResponse(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());
    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase;

    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    final ownerId = (await supabase
        .from("owners")
        .select("id")
        .eq("user_id", userId))[0]["id"];

    await supabase.from("activities").insert({
      "activity_name": body["activity_name"],
      "activity_price": body["activity_price"],
      "activity_location": body["activity_location"],
      "activity_description": body["activity_description"],
      "activity_pic": body["activity_pic"],
      "owner_id": ownerId,
    });

    return ResponseMsg().successResponse(
      msg: "add Activity success",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
