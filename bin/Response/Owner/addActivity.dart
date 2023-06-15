import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

addActivity(Request req) async {
  try {
    final body = (await req.read());

    print(body.runtimeType);

    return Response.ok("$body");
  } catch (e) {
    return Response.forbidden("$e");
  }
}
