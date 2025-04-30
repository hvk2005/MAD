import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/material_service.dart';
import '../models/material.dart' as models;
import '../constants/theme_constants.dart';

class MaterialListScreen extends StatefulWidget {
  const MaterialListScreen({super.key});

  @override
  State<MaterialListScreen> createState() => _MaterialListScreenState();
}

class _MaterialListScreenState extends State<MaterialListScreen> {
  List<models.Material> _materials = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMaterials();
  }

  Future<void> _loadMaterials() async {
    try {
      final materialService = Provider.of<MaterialService>(
        context,
        listen: false,
      );
      final materials = await materialService.getMaterials();
      if (mounted) {
        setState(() {
          _materials = materials;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materials'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadMaterials,
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _materials.isEmpty
              ? const Center(child: Text('No materials found'))
              : ListView.builder(
                itemCount: _materials.length,
                itemBuilder: (context, index) {
                  final material = _materials[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(material.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Barcode: ${material.barcode}'),
                          Text(
                            'Unit Cost: \$${material.unitCost.toStringAsFixed(2)}',
                          ),
                          Text(
                            'Current Stock: ${material.currentStock} ${material.unitType}',
                          ),
                          if (material.currentStock <= material.minimumStock)
                            const Text(
                              'Low Stock Alert!',
                              style: TextStyle(
                                color: ThemeConstants.warningColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                      trailing: Text(
                        '${material.currentStock} ${material.unitType}',
                        style: TextStyle(
                          color:
                              material.currentStock <= material.minimumStock
                                  ? ThemeConstants.warningColor
                                  : ThemeConstants.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
