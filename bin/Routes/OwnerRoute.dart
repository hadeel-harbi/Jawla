import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/CheckTokenMiddelware.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router();

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
