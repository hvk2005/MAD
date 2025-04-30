class Material {
  final String id;
  final String name;
  final String barcode;
  final double unitCost;
  final String unitType;
  final double currentStock;
  final double minimumStock;
  final DateTime lastUpdated;

  Material({
    required this.id,
    required this.name,
    required this.barcode,
    required this.unitCost,
    required this.unitType,
    required this.currentStock,
    required this.minimumStock,
    required this.lastUpdated,
  });

  Material copyWith({
    String? id,
    String? name,
    String? barcode,
    double? unitCost,
    String? unitType,
    double? currentStock,
    double? minimumStock,
    DateTime? lastUpdated,
  }) {
    return Material(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      unitCost: unitCost ?? this.unitCost,
      unitType: unitType ?? this.unitType,
      currentStock: currentStock ?? this.currentStock,
      minimumStock: minimumStock ?? this.minimumStock,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'barcode': barcode,
      'unitCost': unitCost,
      'unitType': unitType,
      'currentStock': currentStock,
      'minimumStock': minimumStock,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory Material.fromJson(Map<String, dynamic> json) {
    return Material(
      id: json['id'] as String,
      name: json['name'] as String,
      barcode: json['barcode'] as String,
      unitCost: (json['unitCost'] as num).toDouble(),
      unitType: json['unitType'] as String,
      currentStock: (json['currentStock'] as num).toDouble(),
      minimumStock: (json['minimumStock'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }
}
