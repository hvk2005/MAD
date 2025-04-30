import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/process.dart';
import '../constants/app_constants.dart';

class ProcessService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Process>> getProcesses() async {
    try {
      final snapshot =
          await _firestore.collection(AppConstants.processesCollection).get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Process(
          id: doc.id,
          name: data['name'] as String,
          description: data['description'] as String,
          laborCost: (data['laborCost'] as num).toDouble(),
          energyCost: (data['energyCost'] as num).toDouble(),
          otherCosts: (data['otherCosts'] as num).toDouble(),
          requiredMaterials: List<String>.from(data['requiredMaterials']),
          materialQuantities:
              Map<String, double>.from(data['materialQuantities']),
          estimatedTime: (data['estimatedTime'] as num).toDouble(),
          status: data['status'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get processes: $e');
    }
  }

  Future<Process?> getProcessById(String processId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.processesCollection)
          .doc(processId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        return Process(
          id: doc.id,
          name: data['name'] as String,
          description: data['description'] as String,
          laborCost: (data['laborCost'] as num).toDouble(),
          energyCost: (data['energyCost'] as num).toDouble(),
          otherCosts: (data['otherCosts'] as num).toDouble(),
          requiredMaterials: List<String>.from(data['requiredMaterials']),
          materialQuantities:
              Map<String, double>.from(data['materialQuantities']),
          estimatedTime: (data['estimatedTime'] as num).toDouble(),
          status: data['status'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get process by ID: $e');
    }
  }

  Future<List<Process>> getProcessesByOperator(String operatorId) async {
    try {
      final snapshot = await _firestore
          .collection(AppConstants.processesCollection)
          .where('requiredMaterials', arrayContains: operatorId)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Process(
          id: doc.id,
          name: data['name'] as String,
          description: data['description'] as String,
          laborCost: (data['laborCost'] as num).toDouble(),
          energyCost: (data['energyCost'] as num).toDouble(),
          otherCosts: (data['otherCosts'] as num).toDouble(),
          requiredMaterials: List<String>.from(data['requiredMaterials']),
          materialQuantities:
              Map<String, double>.from(data['materialQuantities']),
          estimatedTime: (data['estimatedTime'] as num).toDouble(),
          status: data['status'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get processes by operator: $e');
    }
  }

  Future<double> calculateProcessCost(String processId) async {
    try {
      final process = await getProcessById(processId);
      if (process == null) {
        throw Exception('Process not found');
      }
      return process.totalCost;
    } catch (e) {
      throw Exception('Failed to calculate process cost: $e');
    }
  }
}
