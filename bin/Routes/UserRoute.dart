import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/CheckTokenMiddelware.dart';
import '../Response/User/Favorite/addFavoriteActivityResponse.dart';
import '../Response/User/Favorite/deleteFavoriteActivityResponse.dart';
import '../Response/User/Favorite/displayFavoriteActivitiesResponse.dart';
import '../Response/User/Profile/displayProfileResponse.dart';
import '../Response/User/Profile/editProfileResponse.dart';
import '../Response/User/upgradeToOwnerResponse.dart';
import '../Response/User/Reservation/addReservationResponse.dart';
import '../Response/User/Reservation/deleteReservationResponse.dart';
import '../Response/User/Reservation/displayReservationsResponse.dart';

class UserRoute {
  Handler get handler {
    final router = Router()
      ..get('/add_reservation/<activity_id>', addReservationResponse)
      ..get('/display_reservations', displayReservationsResponse)
      ..get('/delete_reservation/<reser_id>', deleteReservationResponse)
      ..post('/upgrade_to_owner', upgradeToOwnerResponse)
      ..get('/display_profile', displayProfileResponse)
      ..get('/edit_profile', editProfileResponse)
      ..get('/add_favorite/<activity_id>', addFavoriteActivityResponse)
      ..get('/display_favorites', displayFavoriteActivitiesResponse)
      ..get('/delete_favorite/<activity_id>', deleteFavoriteActivityResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
