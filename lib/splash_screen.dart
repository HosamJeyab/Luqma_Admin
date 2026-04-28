import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/core/const/app_image.dart';
import 'package:luqma_admin/provider/auth_provider.dart';
import 'package:luqma_admin/service/firebase_service.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authProvider = context.read<AuthProvider>();
    await authProvider.getSignInStatus();

    if (mounted) {
      if (authProvider.isSignIn) {
        Navigator.pushReplacementNamed(context, '/bottomnavbar');
      } else {
        if (await DatabaseService().checkIfAdminExists()) {
          Navigator.pushReplacementNamed(context, '/signin');
        } else {
          Navigator.pushReplacementNamed(context, '/signup');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image:
                      Image.asset(
                        AppImage.splashBackground,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ).image,
                ),
              ),
            ),
            const SizedBox(height: 30),
            CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColor.primaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
