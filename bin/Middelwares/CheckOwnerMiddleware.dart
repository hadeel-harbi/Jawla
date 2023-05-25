import 'package:shelf/shelf.dart';
import '../RespnseMsg/ResponseMsg.dart';

Middleware checkOwnerMiddleware() => (innerhandler) => (Request req) {
      try {
        if (req.headers["user-type"] != "owner") {
          return ResponseMsg().errorResponse(msg: "You have to be owner!");
        }

        return innerhandler(req);
      } catch (error) {
        return Response.forbidden("$error");
      }
    };
