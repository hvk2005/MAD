import 'package:flutter/material.dart' as material;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../services/material_service.dart';
import '../models/material.dart' as models;

class ScanScreen extends material.StatefulWidget {
  const ScanScreen({super.key});

  @override
  material.State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends material.State<ScanScreen> {
  final MobileScannerController _controller = MobileScannerController();
  models.Material? _scannedMaterial;
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleBarcode(Barcode barcode) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final materialService = Provider.of<MaterialService>(
        context,
        listen: false,
      );
      final material = await materialService.getMaterialByBarcode(
        barcode.rawValue!,
      );
      setState(() {
        _scannedMaterial = material;
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
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(title: const material.Text('Scan Material')),
      body: material.Column(
        children: [
          material.Expanded(
            child: MobileScanner(
              controller: _controller,
              onDetect: (capture) {
                final barcodes = capture.barcodes;
                if (barcodes.isNotEmpty) {
                  _handleBarcode(barcodes.first);
                }
              },
            ),
          ),
          if (_isLoading)
            const material.Padding(
              padding: material.EdgeInsets.all(16.0),
              child: material.CircularProgressIndicator(),
            )
          else if (_error != null)
            material.Padding(
              padding: const material.EdgeInsets.all(16.0),
              child: material.Text('Error: $_error'),
            )
          else if (_scannedMaterial != null)
            material.Padding(
              padding: const material.EdgeInsets.all(16.0),
              child: material.Column(
                crossAxisAlignment: material.CrossAxisAlignment.start,
                children: [
                  material.Text('Material: ${_scannedMaterial!.name}'),
                  material.Text('Barcode: ${_scannedMaterial!.barcode}'),
                  material.Text(
                    'Current Stock: ${_scannedMaterial!.currentStock}',
                  ),
                  material.ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to material details
                    },
                    child: const material.Text('View Details'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
