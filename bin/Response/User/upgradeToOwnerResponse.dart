import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

upgradeToOwnerResponse(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;
    final fromUsers = supabase.from("users");

    // get user Id from (users) table
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    // insert new owner in (Owners) table
    await supabase.from("owners").insert({
      "business_license": body["business_license"],
      "user_id": userId,
    });

    // change (isOwner) to True
    await fromUsers.update({"isOwner": true}).eq("id", userId);

    return ResponseMsg().successResponse(
      msg: "add owner success",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
