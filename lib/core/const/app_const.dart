import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConst {
  static const double padding = 16;
  static const double spacing = 8;

  static final String subaURL = dotenv.env['SUPABASE_URL'] ?? '';
  static final String subaKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
}
