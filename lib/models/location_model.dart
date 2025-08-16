/// نموذج بيانات الموقع البيئي
class EnvironmentalLocation {
  final String id;
  final String name;
  final String type; // bin, plant, recycling_center
  final double latitude;
  final double longitude;
  final String description;
  final int environmentalPoints;
  final String status; // available, full, maintenance
  final DateTime lastUpdated;

  const EnvironmentalLocation({
    required this.id,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.environmentalPoints,
    required this.status,
    required this.lastUpdated,
  });

  /// إنشاء من بيانات JSON
  factory EnvironmentalLocation.fromJson(Map<String, dynamic> json) {
    return EnvironmentalLocation(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      environmentalPoints: json['environmental_points'] ?? 0,
      status: json['status'] ?? 'available',
      lastUpdated:
          DateTime.tryParse(json['last_updated'] ?? '') ?? DateTime.now(),
    );
  }

  /// تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'environmental_points': environmentalPoints,
      'status': status,
      'last_updated': lastUpdated.toIso8601String(),
    };
  }

  /// إنشاء نسخة محدثة
  EnvironmentalLocation copyWith({
    String? id,
    String? name,
    String? type,
    double? latitude,
    double? longitude,
    String? description,
    int? environmentalPoints,
    String? status,
    DateTime? lastUpdated,
  }) {
    return EnvironmentalLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      description: description ?? this.description,
      environmentalPoints: environmentalPoints ?? this.environmentalPoints,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// الحصول على أيقونة حسب النوع
  String get iconPath {
    switch (type) {
      case 'bin':
        return 'assets/icons/smart_bin.png';
      case 'plant':
        return 'assets/icons/plant.png';
      case 'recycling_center':
        return 'assets/icons/recycling.png';
      default:
        return 'assets/icons/default.png';
    }
  }

  /// لون حسب الحالة
  String get statusColor {
    switch (status) {
      case 'available':
        return '#4CAF50'; // أخضر
      case 'full':
        return '#F44336'; // أحمر
      case 'maintenance':
        return '#FF9800'; // برتقالي
      default:
        return '#9E9E9E'; // رمادي
    }
  }
}
