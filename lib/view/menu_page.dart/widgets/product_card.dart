import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/core/utils/snackbar_helper.dart';
import 'package:luqma_admin/provider/menu_provider.dart';
import 'package:luqma_admin/view/menu_page.dart/widgets/edit_image.dart';
import 'package:luqma_admin/view/menu_page.dart/widgets/text_form_edit.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.itemName,
    required this.price,
    required this.category,
    required this.isAvailable,
    required this.imageUrl,
    required this.id,
    required this.description,
    required this.itemNameAr,
    required this.itemNameEn,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  final String? itemName;
  final double? price;
  final String? category;
  final bool? isAvailable;
  final String? imageUrl;
  final String? id;
  final String? description;
  final String? itemNameAr;
  final String? itemNameEn;
  final String? descriptionAr;
  final String? descriptionEn;

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();

    final String currentLang = context.locale.languageCode;
    final String displayName =
        (currentLang == 'ar' ? itemNameAr : itemNameEn) ?? itemName ?? "";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
        color: AppColor.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: NetworkImage(imageUrl!),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Icon(Icons.fastfood, size: 50),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName, style: AppTextStyle.appbar),
                const SizedBox(height: 4),
                Text("\$$price", style: AppTextStyle.subTitle),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColor.primaryColor.withOpacity(0.15),
                  ),
                  child: Text(
                    category!,
                    style: AppTextStyle.subTitle.copyWith(
                      color: AppColor.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      final nameArController = TextEditingController(
                        text: itemNameAr,
                      );
                      final nameEnController = TextEditingController(
                        text: itemNameEn,
                      );
                      final descArController = TextEditingController(
                        text: descriptionAr,
                      );
                      final descEnController = TextEditingController(
                        text: descriptionEn,
                      );
                      final priceController = TextEditingController(
                        text: price.toString(),
                      );
                      final categoryController = TextEditingController(
                        text: category,
                      );

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("menu_page.edit_product".tr()),
                            content: SizedBox(
                              width: 400,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EditImage(initialImageUrl: imageUrl),
                                    const SizedBox(height: 15),
                                    TextFormEdit(
                                      controller: nameArController,
                                      hintText: "الاسم (عربي)",
                                      labelText: "الاسم (عربي)",
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormEdit(
                                      controller: nameEnController,
                                      hintText: "Name (English)",
                                      labelText: "Name (English)",
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormEdit(
                                      controller: descArController,
                                      hintText: "الوصف (عربي)",
                                      labelText: "الوصف (عربي)",
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormEdit(
                                      controller: descEnController,
                                      hintText: "Description (English)",
                                      labelText: "Description (English)",
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormEdit(
                                      keyboardType: TextInputType.number,
                                      controller: priceController,
                                      hintText: "menu_page.price".tr(),
                                      labelText: "menu_page.price".tr(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "menu_page.cancel".tr(),
                                  style: const TextStyle(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  menuProvider.updateProduct(
                                    id: id!,
                                    itemNameAr: nameArController.text,
                                    itemNameEn: nameEnController.text,
                                    descriptionAr: descArController.text,
                                    descriptionEn: descEnController.text,
                                    price:
                                        double.tryParse(priceController.text) ??
                                        0.0,
                                    category: categoryController.text,
                                    oldImageUrl: imageUrl!,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "menu_page.save".tr(),
                                  style: const TextStyle(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit, color: AppColor.primaryColor),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("menu_page.delete_item".tr()),
                            content: Text("menu_page.are_you_sure".tr()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "menu_page.cancel".tr(),
                                  style: const TextStyle(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  menuProvider.deleteItem(id!, imageUrl!);
                                  Navigator.pop(context);
                                  AppSnackBar.showSuccess(
                                    context,
                                    "menu_page.item_deleted".tr(),
                                  );
                                },
                                child: Text(
                                  "menu_page.delete".tr(),
                                  style: const TextStyle(
                                    color: AppColor.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.delete, color: AppColor.red),
                  ),
                ],
              ),
              // switch availability
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "menu_page.available".tr(),
                    style: AppTextStyle.subTitle.copyWith(fontSize: 12),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      activeColor: AppColor.primaryColor,
                      value: isAvailable ?? false,
                      onChanged:
                          (value) => menuProvider.toggleProductAvailability(
                            id!,
                            isAvailable ?? false,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
