class SystemMetrics {
  const SystemMetrics({
    required this.cpu,
    required this.ram,
    required this.network,
    required this.updatedAt,
  });

  final double cpu;
  final double ram;
  final double network;
  final DateTime updatedAt;
}
