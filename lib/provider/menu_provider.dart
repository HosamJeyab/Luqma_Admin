import 'dart:io';
import 'package:flutter/material.dart';
import 'package:luqma_admin/service/firebase_service.dart';

class MenuProvider extends ChangeNotifier {
  bool isAvailable = false;
  File? pickedImage;
  bool isLoading = false;
  Stream<List<Map<String, dynamic>>> get menuStream =>
      _firebaseService.getItemsStream();
  final DatabaseService _firebaseService = DatabaseService();
  //constructor
  MenuProvider();

  //toggle available
  void toggleAvailable() {
    isAvailable = !isAvailable;
    notifyListeners();
  }

  //clear picked image
  void clear() {
    pickedImage = null;
    notifyListeners();
  }

  //set picked image
  void setPickedImage(File image) {
    pickedImage = image;
    notifyListeners();
  }

  //add item
  Future<void> addItem({
    required String itemNameAr,
    required String itemNameEn,
    required String descriptionAr,
    required String descriptionEn,
    required double price,
    required String category,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      String? imageUrl;
      if (pickedImage != null) {
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        imageUrl = await _firebaseService.uploadImage(pickedImage!, fileName);
      }

      // إرسال البيانات الـ 4 الجديدة لـ Firebase
      await _firebaseService.addItem(
        itemNameAr: itemNameAr,
        itemNameEn: itemNameEn,
        descriptionAr: descriptionAr,
        descriptionEn: descriptionEn,
        price: price,
        category: category,
        isAvailable: isAvailable,
        imageUrl: imageUrl,
      );
    } catch (e) {
      debugPrint("Add Item Error: $e");
      rethrow; // لنتمكن من التقاط الخطأ في الـ UI وإظهار SnackBar
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //update item
  Future<void> updateProduct({
    required String id,
    required String itemNameAr,
    required String itemNameEn,
    required String descriptionAr,
    required String descriptionEn,
    required double price,
    required String category,
    String? oldImageUrl,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      String? finalImageUrl = oldImageUrl;

      if (pickedImage != null) {
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        finalImageUrl = await _firebaseService.editImage(
          pickedImage!,
          fileName,
        );
      }

      await _firebaseService.updateItem(
        id: id,
        itemNameAr: itemNameAr,
        itemNameEn: itemNameEn,
        descriptionAr: descriptionAr,
        descriptionEn: descriptionEn,
        price: price,
        category: category,
        imageUrl: finalImageUrl,
      );

      clear();
    } catch (e) {
      debugPrint("Update Error: $e");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //delete item
  Future<void> deleteItem(String id, String imageUrl) async {
    try {
      isLoading = true;
      notifyListeners();
      await _firebaseService.deleteItem(id, imageUrl);
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //update Avaliable
  Future<void> toggleProductAvailability(String id, bool currentStatus) async {
    try {
      await _firebaseService.updateAvailability(id, !currentStatus);
    } catch (e) {
      print("Error updating availability: $e");
    }
  }
}
