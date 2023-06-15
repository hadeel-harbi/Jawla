import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

//check

forgotPasswordResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final supabase = SupabaseEnv().supabase;

    if (body['email'] == null) {
      return ResponseMsg().successResponse(
        msg: " add email please",
      );
    }
    var byEmail =
        await supabase.from("users").select().eq("email", body["email"]);

    if (byEmail.isNotEmpty) {
      await supabase.auth.resetPasswordForEmail(body['email']);

      return ResponseMsg().successResponse(
        msg: "check your email to get verify code",
        data: {"email": body['email']},
      );
    }

    return ResponseMsg().successResponse(msg: "Email not found !");
  } catch (error) {
    return ResponseMsg().successResponse(msg: " error ! $error");
  }
}
