import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/CheckTokenMiddelware.dart';
import '../Response/Owner/addActivityResponse.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router()..post('/add_activity', addActivityResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
