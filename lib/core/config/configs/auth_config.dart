class AuthConfig {
  final String endpoint;
  final bool useJwt;

  const AuthConfig({
    required this.endpoint,
    required this.useJwt,
  });
}