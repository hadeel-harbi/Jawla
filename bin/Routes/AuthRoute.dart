import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Response/Auth/createAccountResponse.dart';
import '../Response/Auth/forgot_password_response.dart';
import '../Response/Auth/loginResponse.dart';
import '../Response/Auth/update_password_response.dart';
import '../Response/Auth/verifyEmailResoponse.dart';

class AuthRoute {
  Handler get handler {
    final router = Router()
      ..post('/create_account', createAccountResponse)
      ..post('/verify_email', verifyAccountResponse)
      ..post('/login', loginResponse)
      ..post('/forget_password', forgotPasswordResponse)
      ..post('/update_password', updatePasswordResponse);

    return router;
  }
}
