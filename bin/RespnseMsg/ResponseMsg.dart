import 'dart:convert';

import 'package:shelf/shelf.dart';

class ResponseMsg {
  errorResponse({required String msg}) {
    return Response.badRequest(
      headers: {'content-type': 'application/json'},
      body: json.encode({'msg': msg, 'statusCode': 400}),
    );
  }

  successResponse({required String msg, Map? data}) {
    return Response.ok(
      headers: {'content-type': 'application/json'},
      json.encode({'msg': msg, 'statusCode': 200, ...data ?? {}}),
    );
  }

  unauthorizedResponse({required String msg, Map<String, dynamic>? data}) {
    return Response.unauthorized(
      headers: {"content-type": "application/json"},
      json.encode({
        "statusCode": 401,
        "msg": msg,
        ...data ?? {},
      }),
    );
  }
}
