import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/CheckOwnerMiddleware.dart';
import '../Response/Owner/addActivityResponse.dart';
import '../Response/Owner/deleteActivityResponse.dart';
import '../Response/Owner/displayAllOwnerActivitiesResponse.dart';
import '../Response/Owner/displayActivityReservationsResponse.dart';
import '../Response/Owner/editActivityResponse.dart';

class OwnerRoute {
  Handler get handler {
    final router = Router()
      ..post('/add_activity', addActivityResponse)
      ..put('/edit_activity/<id>', editActivityResponse)
      ..delete('/delete_activity_byid/<id>', deleteActivityByIdResponse)
      ..get('/display_owner_activities', displayAllOwnerActivitiesResponse)
      ..get(
        '/display_activity_reservations/<id>',
        displayActivityReservationsResponse,
      );

    final pipline =
        Pipeline().addMiddleware(checkOwnerMiddleware()).addHandler(router);

    return pipline;
  }
}
