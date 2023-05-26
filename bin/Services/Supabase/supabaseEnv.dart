import 'package:supabase/supabase.dart';

class SupabaseEnv {
  final _url = 'https://sxkrpozapvaajvnqomgh.supabase.co';
  final _key =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4a3Jwb3phcHZhYWp2bnFvbWdoIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4NDc1MzIwOCwiZXhwIjoyMDAwMzI5MjA4fQ.apDIqjXgJEx-yha-Bqa4pd-BTJtXEerhSjDJoSV4Fog';
  final _JWT =
      '+Kj645IUwhphn8C5YsYj4Mm4jd4O1VMBeVy9icWZfRxaBuwH9bL+NslMX6lWnw3fOZkWv6QeNxF+IbK0l7At9Q==';

  get getJWT {
    return _JWT;
  }

  SupabaseClient get supabase {
    final supabase = SupabaseClient(_url, _key);

    return supabase;
  }
}
