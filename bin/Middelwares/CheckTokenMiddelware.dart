import 'package:shelf/shelf.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../RespnseMsg/ResponseMsg.dart';
import '../Services/Supabase/supabaseEnv.dart';

Middleware checkTokenMiddleware() => (innerhandler) => (Request req) {
      try {
        if (!req.headers.containsKey("authorization")) {
          return ResponseMsg().errorResponse(msg: "You don't have access!");
        }

        final token = req.headers['authorization'].toString().trim();
        // Verify a token
        JWT.verify(token, SecretKey(SupabaseEnv().getJWT));

        return innerhandler(req);
      } on JWTExpiredError {
        return Response.forbidden("Expired");
      } catch (error) {
        return Response.forbidden("$error");
      }
    };
