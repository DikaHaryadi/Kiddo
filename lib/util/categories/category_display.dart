import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textspeech/interface/edit_profile.dart';
import 'package:textspeech/util/app_colors.dart';
import 'package:textspeech/util/categories/category_controller.dart';
import 'package:textspeech/util/categories/sub_category_screen.dart';
import 'package:textspeech/util/shimmer.dart';

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

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemCount: 6,
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DShimmerEffect(
                width: 55,
                height: 55,
                radius: 55,
              ),
              SizedBox(
                height: 8.0,
              ),
              DShimmerEffect(width: 55, height: 8)
            ],
          );
        },
      ),
    );
  }
}

class VerticalImageText extends StatelessWidget {
  const VerticalImageText(
      {super.key,
      this.textColor = kDark,
      required this.image,
      required this.title,
      this.bgColor,
      this.isNetworkImage = true,
      this.onTap});

  final Color textColor;
  final String image, title;
  final Color? bgColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            CircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: 8.0 * 1.4,
              isNetworkImage: isNetworkImage,
              overlayColor: kDark,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
