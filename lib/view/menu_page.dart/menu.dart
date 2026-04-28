import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/const/app_text_style.dart';
import 'package:luqma_admin/core/widgets/appbar.dart';
import 'package:luqma_admin/provider/menu_provider.dart';
import 'package:luqma_admin/view/menu_page.dart/widgets/product_card.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(
          title: "menu_page.menu".tr(),
          icon: Icons.food_bank_outlined,
        ),
      ),
      body:
          menuProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : SafeArea(
                child: StreamBuilder(
                  stream: menuProvider.menuStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'menu_page.error'.tr() + ': ${snapshot.error}'.tr(),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final menuItems = snapshot.data ?? [];
                    if (menuItems.isEmpty) {
                      return Center(
                        child: Text(
                          "menu_page.no_items_yet".tr(),
                          style: AppTextStyle.appbar,
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.all(AppConst.padding),

                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          itemNameAr: menuItems[index]['itemNameAr'],
                          itemNameEn: menuItems[index]['itemNameEn'],
                          descriptionAr: menuItems[index]['descriptionAr'],
                          descriptionEn: menuItems[index]['descriptionEn'],
                          id: menuItems[index]['id'],
                          itemName: menuItems[index]['itemName'],
                          price: menuItems[index]['price'],
                          category: menuItems[index]['category'],
                          isAvailable: menuItems[index]['isAvailable'],
                          imageUrl: menuItems[index]['imageUrl'],
                          description: menuItems[index]['description'],
                        );
                      },
                    );
                  },
                ),
              ),
    );
  }
}
