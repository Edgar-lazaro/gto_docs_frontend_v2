class Configurations {
  static const String version = '1.0.0';

  /// Configuración opcional para Supabase (si se usa modo online).
  ///
  /// Inyecta valores con:
  /// `flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...`
  static const String mSupabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );
  static const String mSupabaseKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );
}
