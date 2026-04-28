import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:luqma_admin/core/const/app_image.dart';
import 'package:luqma_admin/view/setting_page/widgets/url_packege.dart';

class ContactUtils {
  static void showContactOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              //email
              ListTile(
                leading: Image.asset(AppImage.email, height: 30, width: 30),
                title: Text('setting_page.email'.tr()),
                onTap: () {
                  UrlPackage().openEmail();
                },
              ),
              SizedBox(width: 20),
              Divider(),
              //whatsapp
              ListTile(
                leading: Image.asset(AppImage.whatsapp, height: 30, width: 30),
                title: Text('setting_page.whats_app'.tr()),
                onTap: () {
                  UrlPackage().openWhatsApp();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
