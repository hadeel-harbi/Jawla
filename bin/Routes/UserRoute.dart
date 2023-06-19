import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/CheckTokenMiddelware.dart';
import '../Response/User/Activity/displayActivityByIdResponse.dart';
import '../Response/User/Activity/displayAllActivitiesResponse.dart';
import '../Response/User/Activity/searchActivityResponse.dart';
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
      ..get('/display_all_activities', displayAllActivitiesResponse)
      ..get('/display_activity_byid/<activity_id>', displayActivityByIdResponse)
      ..get('/add_reservation/<activity_id>', addReservationResponse)
      ..get('/display_reservations', displayReservationsResponse)
      ..delete('/delete_reservation/<reser_id>', deleteReservationResponse)
      ..post('/upgrade_to_owner', upgradeToOwnerResponse)
      ..get('/display_profile', displayProfileResponse)
      ..put('/edit_profile', editProfileResponse)
      ..get('/add_favorite/<activity_id>', addFavoriteActivityResponse)
      ..get('/display_favorites', displayFavoriteActivitiesResponse)
      ..delete('/delete_favorite/<activity_id>', deleteFavoriteActivityResponse)
      ..get('/search_activity/<text>', searchActivitResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
