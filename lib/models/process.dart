import 'package:hive/hive.dart';

part 'process.g.dart';

@HiveType(typeId: 3)
class Process {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double laborCost;

  @HiveField(4)
  final double energyCost;

  @HiveField(5)
  final double otherCosts;

  @HiveField(6)
  final List<String> requiredMaterials;

  @HiveField(7)
  final Map<String, double> materialQuantities;

  Process({
    required this.id,
    required this.name,
    required this.description,
    required this.laborCost,
    required this.energyCost,
    required this.otherCosts,
    required this.requiredMaterials,
    required this.materialQuantities,
  });

  double get totalCost => laborCost + energyCost + otherCosts;

  Process copyWith({
    String? id,
    String? name,
    String? description,
    double? laborCost,
    double? energyCost,
    double? otherCosts,
    List<String>? requiredMaterials,
    Map<String, double>? materialQuantities,
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
    );
  }
}
