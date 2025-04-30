import 'package:hive/hive.dart';

part 'material.g.dart';

@HiveType(typeId: 2)
class Material {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String barcode;

  @HiveField(3)
  final double unitCost;

  @HiveField(4)
  final String unitType;

  @HiveField(5)
  final double currentStock;

  @HiveField(6)
  final double minimumStock;

  @HiveField(7)
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
}
