class EvidenceConfig {
  final int maxFileSizeMb;
  final List<String> allowedFileTypes;

  const EvidenceConfig({
    required this.maxFileSizeMb,
    required this.allowedFileTypes,
  });
}