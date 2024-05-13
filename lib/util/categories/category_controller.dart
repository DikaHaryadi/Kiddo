import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:textspeech/util/app_colors.dart';
import 'package:textspeech/util/categories/category_model.dart';
import 'package:textspeech/util/categories/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepo = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;
  // Load category data
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load selected category data
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;

      // fetch categories from data source
      final categories = await _categoryRepo.getAllCategories();
      // update the categories list
      allCategories.assignAll(categories);
      // filter featured categories
      featureCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(5)
          .toList()); // categories nya ada 5, mangkanya ditulis 5
    } catch (e) {
      Get.snackbar(
        'Oh Snap',
        e.toString(),
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: kSoftblue,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.warning_2, color: Colors.white),
      );
      print('ini error di category controller :' + e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get category or sub category
}
