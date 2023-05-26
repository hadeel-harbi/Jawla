import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middelwares/CheckTokenMiddelware.dart';
import '../Response/Owner/addActivityResponse.dart';
import '../Response/Owner/displayAllOwnerActivityResponse.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router()
    ..post('/add_activity', addActivityResponse)
    ..get('/getAllactivity', getAllActivityResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
