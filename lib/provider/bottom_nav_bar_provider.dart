import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int selectedIndex = 0;
  late PageController pageController;

  BottomNavBarProvider() {
    pageController = PageController();
  }
  //reset page controller
  void reset() {
    if (pageController.hasClients) {
      pageController.dispose();
    }
    pageController = PageController();
    selectedIndex = 0;
    notifyListeners();
  }

  void changePage(int index, {bool animate = true}) {
    if (pageController.hasClients) {
      selectedIndex = index;
      if (animate) {
        pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        pageController.jumpToPage(index);
      }
      notifyListeners();
    }
  }

  void onPageChanged(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
