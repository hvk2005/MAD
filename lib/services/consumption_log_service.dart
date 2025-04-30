  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/consumption_log.dart';
import '../constants/app_constants.dart';

class ConsumptionLogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  Future<void> logConsumption({
    required String materialId,
    required String processId,
    required String operatorId,
    required double quantity,
    required String notes,
  }) async {
    try {
      final log = ConsumptionLog(
        id: _uuid.v4(),
        materialId: materialId,
        processId: processId,
        operatorId: operatorId,
        quantity: quantity,
        timestamp: DateTime.now(),
        notes: notes,
        isSynced: true,
      );

      await _firestore
          .collection(AppConstants.consumptionLogsCollection)
          .doc(log.id)
          .set(log.toJson());
    } catch (e) {
      throw Exception('Failed to log consumption: $e');
    }
  }

  Future<List<ConsumptionLog>> getConsumptionLogs({
    String? materialId,
    String? processId,
    String? operatorId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          _firestore.collection(AppConstants.consumptionLogsCollection);

      if (materialId != null) {
        query = query.where('materialId', isEqualTo: materialId);
      }
      if (processId != null) {
        query = query.where('processId', isEqualTo: processId);
      }
      if (operatorId != null) {
        query = query.where('operatorId', isEqualTo: operatorId);
      }
      if (startDate != null) {
        query = query.where('timestamp', isGreaterThanOrEqualTo: startDate);
      }
      if (endDate != null) {
        query = query.where('timestamp', isLessThanOrEqualTo: endDate);
      }

      final snapshot = await query.get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ConsumptionLog(
          id: doc.id,
          materialId: data['materialId'] as String,
          processId: data['processId'] as String,
          operatorId: data['operatorId'] as String,
          quantity: (data['quantity'] as num).toDouble(),
          timestamp: (data['timestamp'] as Timestamp).toDate(),
          notes: data['notes'] as String,
          isSynced: data['isSynced'] as bool? ?? true,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get consumption logs: $e');
    }
  }

  Future<Map<String, double>> getMaterialConsumptionSummary({
    required String materialId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final logs = await getConsumptionLogs(
        materialId: materialId,
        startDate: startDate,
        endDate: endDate,
      );

      final totalConsumption = logs.fold<double>(
        0,
        (sum, log) => sum + log.quantity,
      );

      return {
        'totalConsumption': totalConsumption,
        'averageDailyConsumption': startDate != null && endDate != null
            ? totalConsumption / (endDate.difference(startDate).inDays + 1)
            : 0,
      };
    } catch (e) {
      throw Exception('Failed to get material consumption summary: $e');
    }
  }
}
