import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/util/app_colors.dart';
import 'package:textspeech/util/categories/category_controller.dart';
import 'package:textspeech/util/categories/sub_category_screen.dart';

import '../shimmer/category_shimmer.dart';

class CategoriesDisplay extends StatelessWidget {
  const CategoriesDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      if (categoryController.isLoading.value) return const CategoryShimmer();
      if (categoryController.featureCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found!',
            style: Theme.of(context).textTheme.bodyMedium!.apply(color: kGrey),
          ),
        );
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryController.featureCategories.length,
          itemBuilder: (_, index) {
            final category = categoryController.featureCategories[index];
            return VerticalImageText(
              image: category.image,
              title: category.name,
              onTap: () => Get.to(() => const SubCategoryScreen()),
            );
          },
        ),
      );
    });
  }
}
