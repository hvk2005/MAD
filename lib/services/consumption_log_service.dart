import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:uuid/uuid.dart';
import '../models/consumption_log.dart';
import '../constants/app_constants.dart';

class ConsumptionLogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Connectivity _connectivity = Connectivity();
  final Uuid _uuid = const Uuid();

  Future<void> logConsumption({
    required String materialId,
    required String processId,
    required String operatorId,
    required double quantity,
  }) async {
    try {
      final log = ConsumptionLog(
        id: _uuid.v4(),
        materialId: materialId,
        processId: processId,
        operatorId: operatorId,
        quantity: quantity,
        timestamp: DateTime.now(),
        isSynced: false,
      );

      // Save to local storage
      final logsBox = await Hive.openBox<ConsumptionLog>(
        AppConstants.consumptionLogsBox,
      );
      await logsBox.put(log.id, log);

      // Try to sync with Firestore if online
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult != ConnectivityResult.none) {
        await _syncLog(log);
      }
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
      final logsBox = await Hive.openBox<ConsumptionLog>(
        AppConstants.consumptionLogsBox,
      );
      var logs = logsBox.values.toList();

      // Apply filters
      if (materialId != null) {
        logs = logs.where((log) => log.materialId == materialId).toList();
      }
      if (processId != null) {
        logs = logs.where((log) => log.processId == processId).toList();
      }
      if (operatorId != null) {
        logs = logs.where((log) => log.operatorId == operatorId).toList();
      }
      if (startDate != null) {
        logs = logs.where((log) => log.timestamp.isAfter(startDate)).toList();
      }
      if (endDate != null) {
        logs = logs.where((log) => log.timestamp.isBefore(endDate)).toList();
      }

      return logs;
    } catch (e) {
      throw Exception('Failed to get consumption logs: $e');
    }
  }

  Future<void> syncPendingLogs() async {
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return;
      }

      final logsBox = await Hive.openBox<ConsumptionLog>(
        AppConstants.consumptionLogsBox,
      );
      final pendingLogs = logsBox.values.where((log) => !log.isSynced).toList();

      for (var log in pendingLogs) {
        await _syncLog(log);
      }
    } catch (e) {
      throw Exception('Failed to sync pending logs: $e');
    }
  }

  Future<void> _syncLog(ConsumptionLog log) async {
    try {
      await _firestore
          .collection(AppConstants.consumptionLogsCollection)
          .doc(log.id)
          .set({
            'materialId': log.materialId,
            'processId': log.processId,
            'operatorId': log.operatorId,
            'quantity': log.quantity,
            'timestamp': Timestamp.fromDate(log.timestamp),
          });

      // Update local storage
      final logsBox = await Hive.openBox<ConsumptionLog>(
        AppConstants.consumptionLogsBox,
      );
      await logsBox.put(log.id, log.copyWith(isSynced: true));
    } catch (e) {
      throw Exception('Failed to sync log: $e');
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
        'averageDailyConsumption':
            startDate != null && endDate != null
                ? totalConsumption / (endDate.difference(startDate).inDays + 1)
                : 0,
      };
    } catch (e) {
      throw Exception('Failed to get material consumption summary: $e');
    }
  }
}
