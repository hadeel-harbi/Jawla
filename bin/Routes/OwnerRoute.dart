import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/CheckTokenMiddelware.dart';
import '../Response/Owner/addActivityResponse.dart';
import '../Response/Owner/deleteActivityResponse.dart';
import '../Response/Owner/displayAllActivityResponse.dart';
import '../Response/Owner/editActivityResponse.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router()
      ..post('/add_activity', addActivityResponse)
      ..put('/edit_activity', editActivityResponse)
      ..get('/display_activities', displayAllActivityResponse)
      ..delete('/delete_activity_by_id/<id>', deleteActivityByIdResponse);
    // ..get('/display_owner_activities', displayAllOwnerActivitiesResponse)
    // ..get('/display_activity_reservations/<id>', displayActivityReservationsResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
