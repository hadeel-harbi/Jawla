import 'package:supabase/supabase.dart';

class SupabaseEnv {
  final _url = 'https://oyvnjtbpiwdxmimbkwdn.supabase.co';
  final _key =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im95dm5qdGJwaXdkeG1pbWJrd2RuIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4NTAwOTM5MCwiZXhwIjoyMDAwNTg1MzkwfQ.7DSBCvGGPe41Xp1dBNZqB1msO0IAOVWvZwMcRkZJk5M';
  final _JWT =
      'c4DD/5sUjHD1ZXbadevwJs7iYdTmlWaZT+5vVY9Ws1naJ5vKP8td52JwWzEuWzVjQZi1m3OgKbiAH5NUli0Xow==';

  get getJWT {
    return _JWT;
  }

  SupabaseClient get supabase {
    final supabase = SupabaseClient(_url, _key);

    return supabase;
  }
}
