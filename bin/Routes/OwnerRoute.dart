import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../Middelwares/CheckTokenMiddelware.dart';
import '../Response/Owner/addActivityResponse.dart';
import '../Response/Owner/deleteActivityResponse.dart';
import '../Response/Owner/displayAllOwnerActivityResponse.dart';
import '../Response/User/displayReservationsResponse.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router()
    ..post('/add_activity', addActivityResponse)
    ..get('/display_activities', displayAllActivityResponse)
    ..get('/delete_activity_ById/<id>', deleteActivityByIdResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
