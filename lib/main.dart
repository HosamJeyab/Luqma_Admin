import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_const.dart';
import 'package:luqma_admin/core/widgets/bottom_nav_bar.dart';
import 'package:luqma_admin/firebase_options.dart';
import 'package:luqma_admin/provider/auth_provider.dart';
import 'package:luqma_admin/provider/bottom_nav_bar_provider.dart';
import 'package:luqma_admin/provider/menu_provider.dart';
import 'package:luqma_admin/provider/weekly_chart_provider.dart';
import 'package:luqma_admin/splash_screen.dart';
import 'package:luqma_admin/view/add_product/add_product.dart';
import 'package:luqma_admin/view/change_password/change_password.dart';
import 'package:luqma_admin/view/dashboard_page.dart/dashboard.dart';
import 'package:luqma_admin/view/menu_page.dart/menu.dart';
import 'package:luqma_admin/view/setting_page/widgets/terms_privacy.dart';
import 'package:luqma_admin/view/signin_page/signin_page.dart';
import 'package:luqma_admin/view/signin_page/widgets/forget_password.dart';
import 'package:luqma_admin/view/signup_page/signup_page.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //data base
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(url: AppConst.subaURL, anonKey: AppConst.subaKey);
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider()..loadSettings(),
          ),
          ChangeNotifierProvider(create: (context) => WeeklyChartProvider()),
          ChangeNotifierProvider(create: (context) => MenuProvider()),
          ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ],
        child: const LuqmaAdminApp(),
      ),
    ),
  );
}

class LuqmaAdminApp extends StatelessWidget {
  const LuqmaAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: "luqma Admin",
      debugShowCheckedModeBanner: false,
      routes: {
        '/signin': (context) => SigninPage(),
        '/signup': (context) => SignupPage(),
        '/dashboard': (context) => Dashboard(),
        '/bottomnavbar': (context) => const BottomNavBar(),
        '/menu': (context) => Menu(),
        '/terms_privacy': (context) => const TermsPrivacy(),
        '/change_password': (context) => ChangePassword(),
        '/forget_password': (context) => ForgetPassword(),
        '/add_product': (context) => AddProduct(),
      },
      home: const SplashScreen(),
    );
  }
}
