import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/material.dart';

class MaterialService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Material>> getMaterials() async {
    try {
      final snapshot = await _firestore.collection('materials').get();
      return snapshot.docs.map((doc) => Material.fromJson(doc.data())).toList();
    } catch (e) {
      print('Error getting materials: $e');
      return [];
    }
  }

  Future<Material?> getMaterial(String id) async {
    try {
      final doc = await _firestore.collection('materials').doc(id).get();
      if (doc.exists) {
        return Material.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      print('Error getting material: $e');
      return null;
    }
  }

  Future<Material?> getMaterialByBarcode(String barcode) async {
    try {
      final snapshot = await _firestore
          .collection('materials')
          .where('barcode', isEqualTo: barcode)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return Material.fromJson(snapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      print('Error getting material by barcode: $e');
      return null;
    }
  }

  Future<bool> addMaterial(Material material) async {
    try {
      await _firestore
          .collection('materials')
          .doc(material.id)
          .set(material.toJson());
      return true;
    } catch (e) {
      print('Error adding material: $e');
      return false;
    }
  }

  Future<bool> updateMaterial(Material material) async {
    try {
      await _firestore
          .collection('materials')
          .doc(material.id)
          .update(material.toJson());
      return true;
    } catch (e) {
      print('Error updating material: $e');
      return false;
    }
  }

  Future<bool> deleteMaterial(String id) async {
    try {
      await _firestore.collection('materials').doc(id).delete();
      return true;
    } catch (e) {
      print('Error deleting material: $e');
      return false;
    }
  }
}
