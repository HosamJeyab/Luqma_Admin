import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/utils/handle_back.dart';
import 'package:luqma_admin/provider/bottom_nav_bar_provider.dart';
import 'package:luqma_admin/view/add_product/add_product.dart';
import 'package:luqma_admin/view/dashboard_page.dart/dashboard.dart';
import 'package:luqma_admin/view/menu_page.dart/menu.dart';
import 'package:luqma_admin/view/oreder_page/order.dart';
import 'package:luqma_admin/view/setting_page/setting.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, this.index});
  final int? index;
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Dashboard(),
      Orders(),
      AddProduct(),
      Menu(),
      const Setting(),
    ];

    final bottomNavBarProvider = Provider.of<BottomNavBarProvider>(context);
    return WillPopScope(
      onWillPop: () => HandleBack.handelBack(context),
      child: Scaffold(
        body: PageView(
          controller: bottomNavBarProvider.pageController,
          onPageChanged: (index) {
            bottomNavBarProvider.onPageChanged(index);
          },
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.white,
          selectedIconTheme: IconThemeData(color: AppColor.primaryColor),
          unselectedItemColor: AppColor.secondaryTextColor,
          selectedLabelStyle: TextStyle(color: AppColor.primaryColor),
          unselectedLabelStyle: TextStyle(color: AppColor.secondaryTextColor),
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomNavBarProvider.selectedIndex,
          onTap: (index) {
            bottomNavBarProvider.changePage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "bottom_nav_bar.dashboard".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: "bottom_nav_bar.orders".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: "bottom_nav_bar.add_item".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined),
              label: "bottom_nav_bar.menu".tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: "bottom_nav_bar.settings".tr(),
            ),
          ],
        ),
      ),
    );
  }
}
