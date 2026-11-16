class Warranty {
  final String id, brand, model, maskedImei, provider, status;
  final DateTime purchaseDate;
  final DateTime? expiryDate;

  const Warranty({
    required this.id,
    required this.brand,
    required this.model,
    required this.maskedImei,
    required this.provider,
    required this.status,
    required this.purchaseDate,
    this.expiryDate,
  });
}
