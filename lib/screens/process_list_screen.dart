import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/process_service.dart';
import '../models/process.dart';

class ProcessListScreen extends StatefulWidget {
  const ProcessListScreen({super.key});

  @override
  State<ProcessListScreen> createState() => _ProcessListScreenState();
}

class _ProcessListScreenState extends State<ProcessListScreen> {
  List<Process> _processes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProcesses();
  }

  Future<void> _loadProcesses() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final processService = Provider.of<ProcessService>(
        context,
        listen: false,
      );
      final processes = await processService.getProcesses();
      setState(() {
        _processes = processes;
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
        title: const Text('Processes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProcesses,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Error: $_error'))
              : _processes.isEmpty
              ? const Center(child: Text('No processes found'))
              : ListView.builder(
                itemCount: _processes.length,
                itemBuilder: (context, index) {
                  final process = _processes[index];
                  return ListTile(
                    title: Text(process.name),
                    subtitle: Text(process.description),
                    trailing: Text(
                      '${process.requiredMaterials.length} materials',
                    ),
                    onTap: () {
                      // TODO: Navigate to process details
                    },
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add process screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
