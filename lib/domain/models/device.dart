enum DeviceStatus { online, warning, offline }

class Device {
  const Device({
    required this.name,
    required this.type,
    required this.ipAddress,
    required this.status,
    required this.load,
  });

  final String name;
  final String type;
  final String ipAddress;
  final DeviceStatus status;
  final int load;

  Device copyWith({DeviceStatus? status, int? load}) {
    return Device(
      name: name,
      type: type,
      ipAddress: ipAddress,
      status: status ?? this.status,
      load: load ?? this.load,
    );
  }
}
