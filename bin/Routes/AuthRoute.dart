import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Response/Auth/createAccountResponse.dart';
import '../Response/Auth/loginResponse.dart';
import '../Response/Auth/verifyEmailResoponse.dart';

class AuthRoute {
  Handler get handler {
    final router = Router()
      ..post('/create_account', createAccountResponse)
      ..post('/verify_email', verifyAccountResponse)
      ..post('/login', loginResponse);

    return router;
  }
}
