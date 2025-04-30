import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/consumption_log_service.dart';
import '../models/consumption_log.dart';

class ConsumptionLogScreen extends StatefulWidget {
  const ConsumptionLogScreen({super.key});

  @override
  State<ConsumptionLogScreen> createState() => _ConsumptionLogScreenState();
}

class _ConsumptionLogScreenState extends State<ConsumptionLogScreen> {
  List<ConsumptionLog> _logs = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final logService = Provider.of<ConsumptionLogService>(
        context,
        listen: false,
      );
      final logs = await logService.getConsumptionLogs();
      setState(() {
        _logs = logs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumption Logs'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadLogs),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Error: $_error'))
              : _logs.isEmpty
              ? const Center(child: Text('No consumption logs found'))
              : ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  return ListTile(
                    title: Text('Material ID: ${log.materialId}'),
                    subtitle: Text(
                      'Process ID: ${log.processId}\nQuantity: ${log.quantity}',
                    ),
                    trailing: Text(log.timestamp.toString().split('.')[0]),
                  );
                },
              ),
    );
  }
}
