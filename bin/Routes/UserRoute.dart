import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/CheckTokenMiddelware.dart';
import '../Response/User/addOwnerResponse.dart';
import '../Response/User/addReservationResponse.dart';
import '../Response/User/deleteReservationResponse.dart';
import '../Response/User/displayReservationsResponse.dart';

class UserRoute {
  Handler get handler {
    final router = Router()
      ..get('/add_reservation/<activity_id>', addReservationResponse)
      ..get('/display_reservations', displayReservationsResponse)
      ..get('/delete_reservations/<reser_id>', deleteReservationsResponse)
      ..post('/add_owner', addOwnerResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
