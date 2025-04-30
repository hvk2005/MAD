import 'package:hive/hive.dart';

part 'consumption_log.g.dart';

@HiveType(typeId: 4)
class ConsumptionLog {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String materialId;

  @HiveField(2)
  final String processId;

  @HiveField(3)
  final String operatorId;

  @HiveField(4)
  final double quantity;

  @HiveField(5)
  final DateTime timestamp;

  @HiveField(6)
  final bool isSynced;

  ConsumptionLog({
    required this.id,
    required this.materialId,
    required this.processId,
    required this.operatorId,
    required this.quantity,
    required this.timestamp,
    this.isSynced = false,
  });

  ConsumptionLog copyWith({
    String? id,
    String? materialId,
    String? processId,
    String? operatorId,
    double? quantity,
    DateTime? timestamp,
    bool? isSynced,
  }) {
    return ConsumptionLog(
      id: id ?? this.id,
      materialId: materialId ?? this.materialId,
      processId: processId ?? this.processId,
      operatorId: operatorId ?? this.operatorId,
      quantity: quantity ?? this.quantity,
      timestamp: timestamp ?? this.timestamp,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
