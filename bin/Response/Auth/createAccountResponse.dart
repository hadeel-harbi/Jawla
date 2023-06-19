import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../Models/UserModel.dart';
import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

createAccountResponse(Request req) async {
  try {
    final Map body = jsonDecode(await req.readAsString());

    final supabase = SupabaseEnv().supabase;

    // create new user
    UserResponse userInfo = await supabase.auth.admin.createUser(
      AdminUserAttributes(
        email: body['email'],
        password: body['password'],
      ),
    );

    // send email for Authentication
    // await supabase.auth.signInWithOtp(email: body["email"]);

    // object from user model
    UserModel userObject = UserModel(
      name: body["name"],
      email: body["email"],
      phone: body["phone"],
      idAuth: userInfo.user!.id,
    );

    // insert in users table
    await supabase.from("users").insert(userObject.toMap());

    return ResponseMsg().successResponse(
      msg: "Create account success",
      data: {"email": userObject.email},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
