import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class MaterialModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double unitCost;

  @HiveField(3)
  final String unitType;

  @HiveField(4)
  final double stockLevel;

  @HiveField(5)
  final double minimumStockLevel;

  @HiveField(6)
  final String? barcode;

  @HiveField(7)
  final DateTime lastUpdated;

  @HiveField(8)
  final String? notes;

  @HiveField(9)
  final bool isActive;

  MaterialModel({
    required this.id,
    required this.name,
    required this.unitCost,
    required this.unitType,
    required this.stockLevel,
    required this.minimumStockLevel,
    this.barcode,
    required this.lastUpdated,
    this.notes,
    this.isActive = true,
  });

  bool get isLowStock => stockLevel <= minimumStockLevel;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unitCost': unitCost,
      'unitType': unitType,
      'stockLevel': stockLevel,
      'minimumStockLevel': minimumStockLevel,
      'barcode': barcode,
      'lastUpdated': lastUpdated.toIso8601String(),
      'notes': notes,
      'isActive': isActive,
    };
  }

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'],
      name: json['name'],
      unitCost: json['unitCost'].toDouble(),
      unitType: json['unitType'],
      stockLevel: json['stockLevel'].toDouble(),
      minimumStockLevel: json['minimumStockLevel'].toDouble(),
      barcode: json['barcode'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      notes: json['notes'],
      isActive: json['isActive'] ?? true,
    );
  }

  MaterialModel copyWith({
    String? id,
    String? name,
    double? unitCost,
    String? unitType,
    double? stockLevel,
    double? minimumStockLevel,
    String? barcode,
    DateTime? lastUpdated,
    String? notes,
    bool? isActive,
  }) {
    return MaterialModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unitCost: unitCost ?? this.unitCost,
      unitType: unitType ?? this.unitType,
      stockLevel: stockLevel ?? this.stockLevel,
      minimumStockLevel: minimumStockLevel ?? this.minimumStockLevel,
      barcode: barcode ?? this.barcode,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
    );
  }
}
