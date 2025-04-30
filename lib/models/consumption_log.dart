class ConsumptionLog {
  final String id;
  final String materialId;
  final String processId;
  final double quantity;
  final String operatorId;
  final DateTime timestamp;
  final String notes;
  final bool isSynced;

  ConsumptionLog({
    required this.id,
    required this.materialId,
    required this.processId,
    required this.quantity,
    required this.operatorId,
    required this.timestamp,
    required this.notes,
    this.isSynced = false,
  });

  ConsumptionLog copyWith({
    String? id,
    String? materialId,
    String? processId,
    double? quantity,
    String? operatorId,
    DateTime? timestamp,
    String? notes,
    bool? isSynced,
  }) {
    return ConsumptionLog(
      id: id ?? this.id,
      materialId: materialId ?? this.materialId,
      processId: processId ?? this.processId,
      quantity: quantity ?? this.quantity,
      operatorId: operatorId ?? this.operatorId,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'materialId': materialId,
      'processId': processId,
      'quantity': quantity,
      'operatorId': operatorId,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
      'isSynced': isSynced,
    };
  }

  factory ConsumptionLog.fromJson(Map<String, dynamic> json) {
    return ConsumptionLog(
      id: json['id'] as String,
      materialId: json['materialId'] as String,
      processId: json['processId'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      operatorId: json['operatorId'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      notes: json['notes'] as String,
      isSynced: json['isSynced'] as bool? ?? false,
    );
  }
}
