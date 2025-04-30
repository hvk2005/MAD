class Process {
  final String id;
  final String name;
  final String description;
  final double laborCost;
  final double energyCost;
  final double otherCosts;
  final List<String> requiredMaterials;
  final Map<String, double> materialQuantities;
  final double estimatedTime;
  final String status;
  final DateTime createdAt;

  Process({
    required this.id,
    required this.name,
    required this.description,
    required this.laborCost,
    required this.energyCost,
    required this.otherCosts,
    required this.requiredMaterials,
    required this.materialQuantities,
    required this.estimatedTime,
    required this.status,
    required this.createdAt,
  });

  Process copyWith({
    String? id,
    String? name,
    String? description,
    double? laborCost,
    double? energyCost,
    double? otherCosts,
    List<String>? requiredMaterials,
    Map<String, double>? materialQuantities,
    double? estimatedTime,
    String? status,
    DateTime? createdAt,
  }) {
    return Process(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      laborCost: laborCost ?? this.laborCost,
      energyCost: energyCost ?? this.energyCost,
      otherCosts: otherCosts ?? this.otherCosts,
      requiredMaterials: requiredMaterials ?? this.requiredMaterials,
      materialQuantities: materialQuantities ?? this.materialQuantities,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'laborCost': laborCost,
      'energyCost': energyCost,
      'otherCosts': otherCosts,
      'requiredMaterials': requiredMaterials,
      'materialQuantities': materialQuantities,
      'estimatedTime': estimatedTime,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      laborCost: (json['laborCost'] as num).toDouble(),
      energyCost: (json['energyCost'] as num).toDouble(),
      otherCosts: (json['otherCosts'] as num).toDouble(),
      requiredMaterials: List<String>.from(json['requiredMaterials']),
      materialQuantities: Map<String, double>.from(json['materialQuantities']),
      estimatedTime: (json['estimatedTime'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  double get totalCost => laborCost + energyCost + otherCosts;
}
