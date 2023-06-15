import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'AuthRoute.dart';
import 'OwnerRoute.dart';
import 'UserRoute.dart';

class BaseRoute {
  Handler get handler {
    final router = Router()
      ..get("/", (Request _) {
        return Response.ok("Server is running");
      })
      ..mount('/auth', AuthRoute().handler)
      ..mount('/user', UserRoute().handler)
      ..mount('/owner', OwnerRoute().handler)
      ..all('/<name|.*>', (Request _) {
        return Response.notFound("Page not found! please change your path");
      });

    return router;
  }
}
