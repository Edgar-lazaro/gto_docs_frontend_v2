class BackendConfig {
  final String baseUrl;
  final int port;
  final bool useHttps;

  const BackendConfig({
    required this.baseUrl,
    required this.port,
    required this.useHttps,
  });

  String get fullUrl =>
      '${useHttps ? 'https' : 'http'}://$baseUrl:$port';
}