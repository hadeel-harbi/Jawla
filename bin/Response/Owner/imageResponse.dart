import 'dart:io';
import 'dart:math';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

imageResponse(Request req) async {
  try {
    final body = await req.read().expand((bit) => bit).toList();

    final nameImage = Random().nextInt(999999);

    File image = File(
      'bin/images/$nameImage.png',
    );

    await image.writeAsBytes(body);

    await SupabaseEnv()
        .supabase
        .storage
        .from("images")
        .upload(image.path, image);

    print(image.path);
    final String publicUrl =
        SupabaseEnv().supabase.storage.from('images').getPublicUrl(image.path);

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"data": publicUrl},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: "===$error");
  }
}
