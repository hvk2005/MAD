import 'package:hive/hive.dart';

@HiveType(typeId: 2)
class ConsumptionModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String materialId;

  @HiveField(2)
  final String userId;

  @HiveField(3)
  final double quantity;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final String? processId;

  @HiveField(6)
  final double unitCost;

  @HiveField(7)
  final String notes;

  @HiveField(8)
  final bool isSynced;

  ConsumptionModel({
    required this.id,
    required this.materialId,
    required this.userId,
    required this.quantity,
    required this.timestamp,
    this.processId,
    required this.unitCost,
    this.notes = '',
    this.isSynced = false,
  });

  double get totalCost => quantity * unitCost;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'materialId': materialId,
      'userId': userId,
      'quantity': quantity,
      'timestamp': timestamp.toIso8601String(),
      'processId': processId,
      'unitCost': unitCost,
      'notes': notes,
      'isSynced': isSynced,
    };
  }

  factory ConsumptionModel.fromJson(Map<String, dynamic> json) {
    return ConsumptionModel(
      id: json['id'],
      materialId: json['materialId'],
      userId: json['userId'],
      quantity: json['quantity'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      processId: json['processId'],
      unitCost: json['unitCost'].toDouble(),
      notes: json['notes'] ?? '',
      isSynced: json['isSynced'] ?? false,
    );
  }

  ConsumptionModel copyWith({
    String? id,
    String? materialId,
    String? userId,
    double? quantity,
    DateTime? timestamp,
    String? processId,
    double? unitCost,
    String? notes,
    bool? isSynced,
  }) {
    return ConsumptionModel(
      id: id ?? this.id,
      materialId: materialId ?? this.materialId,
      userId: userId ?? this.userId,
      quantity: quantity ?? this.quantity,
      timestamp: timestamp ?? this.timestamp,
      processId: processId ?? this.processId,
      unitCost: unitCost ?? this.unitCost,
      notes: notes ?? this.notes,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
