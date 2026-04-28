import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luqma_admin/model/oder_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload image to supabase storage
  Future<String?> uploadImage(File file, String fileName) async {
    try {
      final response = await Supabase.instance.client.storage
          .from('image')
          .upload(
            fileName,
            file,
            fileOptions: FileOptions(cacheControl: '3600', upsert: false),
          );

      final url = Supabase.instance.client.storage
          .from('image')
          .getPublicUrl(fileName);

      return url;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  //edit image
  Future<String?> editImage(File file, String fileName) async {
    try {
      await Supabase.instance.client.storage
          .from('image')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final url = Supabase.instance.client.storage
          .from('image')
          .getPublicUrl(fileName);

      return url;
    } catch (e) {
      print('Error updating image: $e');
      return null;
    }
  }

  //add item to firestore
  Future<void> addItem({
    required double price,
    required String category,
    required bool isAvailable,
    required String itemNameAr,
    required String itemNameEn,
    required String descriptionAr,
    required String descriptionEn,
    String? imageUrl,
  }) async {
    await _firestore.collection('menu').add({
      'itemNameAr': itemNameAr,
      'itemNameEn': itemNameEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'price': price,
      'category': category,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
    });
  }

  //get all items
  Stream<List<Map<String, dynamic>>> getItemsStream() {
    return _firestore.collection('menu').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  //delete item
  Future<void> deleteItem(String id, String imageUrl) async {
    await _firestore.collection('menu').doc(id).delete();

    try {
      String fileName = imageUrl.split('/').last;
      await Supabase.instance.client.storage.from('image').remove([fileName]);
    } catch (e) {
      print("Error deleting from Storage: $e");
    }
  }

  //update item
  Future<void> updateItem({
    required String id,
    required String itemNameAr,
    required String itemNameEn,
    required String descriptionAr,
    required String descriptionEn,
    required double price,
    required String category,
    String? imageUrl,
  }) async {
    await _firestore.collection('menu').doc(id).update({
      'itemNameAr': itemNameAr,
      'itemNameEn': itemNameEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
    });
  }

  //update availability
  Future<void> updateAvailability(String docId, bool status) async {
    await _firestore.collection('menu').doc(docId).update({
      'isAvailable': status,
    });
  }

  //get orders
  Stream<List<OrderModel>> getOrders() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            data['orderId'] = doc.id;
            return OrderModel.fromJson(data);
          }).toList();
        });
  }

  //get image from id to display it in order list
  Future<String> getImageUrl(String id) async {
    try {
      final response = await Supabase.instance.client.storage
          .from('image')
          .getPublicUrl(id);
      return response;
    } catch (e) {
      print('Error getting image: $e');
      return "";
    }
  }

  //update order status
  Future<void> updateOrderStatus(
    String orderId,
    String status,
    String? reason,
  ) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status,
      if (reason != null) 'reason': reason,
    });
  }

  //check if admin exists
  Future<bool> checkIfAdminExists() async {
    var snapshot = await FirebaseFirestore.instance.collection('admins').get();
    return snapshot.docs.isNotEmpty;
  }
}
