import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_image.dart';

class logo extends StatelessWidget {
  const logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image:
                Image.asset(
                  AppImage.logo,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ).image,
          ),
        ),
      ),
    );
  }
}
