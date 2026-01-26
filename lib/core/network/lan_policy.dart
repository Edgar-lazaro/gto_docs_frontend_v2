class LanPolicy {
  final List<String> allowedRanges;

  LanPolicy(this.allowedRanges);

  bool isAllowed(String ip) {
    // TODO: implementar CIDR real cuando TI entregue rangos
    return true; // placeholder válido por ahora
  }
}