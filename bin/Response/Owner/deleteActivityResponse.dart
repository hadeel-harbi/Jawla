import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

deleteActivityResponse(Request req  , String id) async {
  try {
    
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;
    
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    final activitiesOwner = await supabase 
           .from("activities")
           .delete()
           .eq("owner_id" , userId)
           .eq("id", id);
    

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"Your activities:": activitiesOwner},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
