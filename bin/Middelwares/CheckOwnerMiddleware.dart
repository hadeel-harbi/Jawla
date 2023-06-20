import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../RespnseMsg/ResponseMsg.dart';
import '../Services/Supabase/supabaseEnv.dart';

Middleware checkOwnerMiddleware() => (innerhandler) => (Request req) async {
      try {
        final jwt = JWT.decode(req.headers["authorization"]!);
        final supabase = SupabaseEnv().supabase.from("users");

        final userId = (await supabase
            .select("id")
            .eq("id_auth", jwt.payload["sub"]))[0]["id"];

        bool owner =
            (await supabase.select("is_owner").eq("id", userId))[0]["is_owner"];
        print(owner);
        if (!owner) {
          return ResponseMsg().errorResponse(msg: "You have to be owner!");
        }

        return innerhandler(req);
      } catch (error) {
        return Response.forbidden("test 1 $error");
      }
    };
