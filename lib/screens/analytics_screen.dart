import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/material_service.dart';
import '../services/process_service.dart';
import '../services/consumption_log_service.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  bool _isLoading = true;
  String? _error;
  Map<String, dynamic> _analytics = {};

  @override
  void initState() {
    super.initState();
    _loadAnalytics();
  }

  Future<void> _loadAnalytics() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final materialService = Provider.of<MaterialService>(
        context,
        listen: false,
      );
      final processService = Provider.of<ProcessService>(
        context,
        listen: false,
      );
      final logService = Provider.of<ConsumptionLogService>(
        context,
        listen: false,
      );

      // TODO: Implement actual analytics calculations
      setState(() {
        _analytics = {
          'totalMaterials': 0,
          'totalProcesses': 0,
          'totalConsumption': 0,
        };
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
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAnalytics,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Error: $_error'))
              : ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildAnalyticsCard(
                    'Total Materials',
                    _analytics['totalMaterials'].toString(),
                    Icons.inventory,
                  ),
                  const SizedBox(height: 16),
                  _buildAnalyticsCard(
                    'Total Processes',
                    _analytics['totalProcesses'].toString(),
                    Icons.engineering,
                  ),
                  const SizedBox(height: 16),
                  _buildAnalyticsCard(
                    'Total Consumption',
                    _analytics['totalConsumption'].toString(),
                    Icons.trending_up,
                  ),
                ],
              ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Text(value, style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
