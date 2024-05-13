import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:textspeech/services/firebase_storage_service.dart';
import 'package:textspeech/util/categories/category_model.dart';
import 'package:textspeech/util/exceptions/firebase_exceptions.dart';
import 'package:textspeech/util/exceptions/format_exceptions.dart';
import 'package:textspeech/util/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list =
          snapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      print('ini categories repository error :' + list.toString());
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('Firebase Error :' + e.toString());
      throw 'Something went wrong. Please try again';
    }
  }

  // Get Sub Categories

  // Upload Categories to the cloud firebase
  Future<void> uploadCategoriesData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(FirebaseStorageService());
      for (var category in categories) {
        // get image link
        final file = await storage.getImageDataFromAssets(category.image);
        // upload image and get its url
        final url = storage.uploadImageData('Categories', file, category.name);
        // assign url to category image attribute
        category.image = url as String;
        // store category in firestore
        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      print('Firebase Upload CategoriesData Error :' + e.toString());
      throw 'Something went wrong. Please try again';
    }
  }
}

// class CategoryData {
//   static final List<CategoryModel> categories = [
//     CategoryModel(id: '1', name: name, image: image, isFeatured: isFeatured)
//   ];
// }
