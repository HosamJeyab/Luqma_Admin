import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/core/utils/snackbar_helper.dart';
import 'package:luqma_admin/core/widgets/appbar.dart';
import 'package:luqma_admin/core/widgets/button.dart';
import 'package:luqma_admin/core/widgets/category.dart';
import 'package:luqma_admin/core/widgets/pick_image.dart';
import 'package:luqma_admin/provider/menu_provider.dart';
import 'package:luqma_admin/view/add_product/widgets/item_info.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatelessWidget {
  // تعريف الـ Controllers لجميع الحقول (Ar & En)
  final TextEditingController itemNameArController = TextEditingController();
  final TextEditingController itemNameEnController = TextEditingController();
  final TextEditingController descriptionArController = TextEditingController();
  final TextEditingController descriptionEnController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: "add_product.add_product".tr(),
          icon: Icons.add_circle_outline_rounded,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppConst.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. قسم الصورة
              const Center(child: PickImage()),
              const SizedBox(height: 25),

              // 2. قسم المعلومات بالعربي (Arabic Section)
              _buildLanguageSection(
                context,
                title: "المعلومات بالعربية",
                icon: Icons.language,
                children: [
                  ItemInfo(
                    itemName: "اسم المنتج (عربي)",
                    decoration: "مثال: برجر دجاج حار",
                    controller: itemNameArController,
                  ),
                  const SizedBox(height: 15),
                  ItemInfo(
                    itemName: "الوصف (عربي)",
                    decoration: "اكتب تفاصيل المنتج بالعربية...",
                    maxLines: 3,
                    controller: descriptionArController,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 3. قسم المعلومات بالإنجليزي (English Section)
              _buildLanguageSection(
                context,
                title: "English Information",
                icon: Icons.translate,
                children: [
                  ItemInfo(
                    itemName: "Product Name (English)",
                    decoration: "e.g. Spicy Chicken Burger",
                    controller: itemNameEnController,
                  ),
                  const SizedBox(height: 15),
                  ItemInfo(
                    itemName: "Description (English)",
                    decoration: "Enter product details in English...",
                    maxLines: 3,
                    controller: descriptionEnController,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 4. السعر والتصنيف
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  ${"add_product.price".tr()}",
                          style: AppTextStyle.appbar,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: priceController,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "0.00",
                            prefixIcon: const Icon(
                              Icons.attach_money,
                              color: AppColor.primaryColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  ${"add_product.category".tr()}",
                          style: AppTextStyle.appbar,
                        ),
                        const SizedBox(height: 8),
                        Category(controller: categoryController),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // 5. حالة التوفر (Available Switch)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColor.primaryColor.withOpacity(0.2),
                  ),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppColor.primaryColor,
                    child: Icon(
                      Icons.inventory_2_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    "add_product.available".tr(),
                    style: AppTextStyle.appbar,
                  ),
                  subtitle: Text(
                    "add_product.is_available".tr(),
                    style: AppTextStyle.subAppbar.copyWith(fontSize: 12),
                  ),
                  trailing: Switch.adaptive(
                    activeColor: AppColor.primaryColor,
                    value: menuProvider.isAvailable,
                    onChanged: (value) => menuProvider.toggleAvailable(),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // 6. زر الإضافة النهائي
              Button<MenuProvider>(
                text: "add_product.add_item".tr(),
                loadingSelector: (provider) => provider.isLoading,
                onTap: () async {
                  // التحقق من الصورة
                  if (menuProvider.pickedImage == null) {
                    AppSnackBar.showError(
                      context,
                      "add_product.pick_image".tr(),
                    );
                    return;
                  }

                  // التحقق من جميع الحقول (Ar & En)
                  if (itemNameArController.text.isEmpty ||
                      itemNameEnController.text.isEmpty ||
                      descriptionArController.text.isEmpty ||
                      descriptionEnController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      categoryController.text.isEmpty) {
                    AppSnackBar.showError(
                      context,
                      "add_product.fill_fields".tr(),
                    );
                    return;
                  }

                  try {
                    await menuProvider.addItem(
                      itemNameAr: itemNameArController.text,
                      itemNameEn: itemNameEnController.text,
                      descriptionAr: descriptionArController.text,
                      descriptionEn: descriptionEnController.text,
                      price: double.parse(priceController.text),
                      category: categoryController.text,
                    );

                    // تفريغ الحقول بعد النجاح
                    _clearAllControllers();
                    menuProvider.clear();

                    AppSnackBar.showSuccess(
                      context,
                      "add_product.item_added".tr(),
                    );
                  } catch (e) {
                    AppSnackBar.showError(
                      context,
                      "add_product.failed_add".tr(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت لبناء أقسام اللغات بشكل منظم
  Widget _buildLanguageSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: AppColor.primaryColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyle.appbar.copyWith(
                  color: AppColor.primaryColor,
                ),
              ),
            ],
          ),
          const Divider(height: 25, thickness: 0.5),
          ...children,
        ],
      ),
    );
  }

  void _clearAllControllers() {
    itemNameArController.clear();
    itemNameEnController.clear();
    descriptionArController.clear();
    descriptionEnController.clear();
    priceController.clear();
    categoryController.clear();
  }
}
