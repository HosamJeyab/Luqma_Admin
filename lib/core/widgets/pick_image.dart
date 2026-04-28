import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luqma_admin/core/const/app_color.dart';
import 'package:luqma_admin/provider/menu_provider.dart';
import 'package:provider/provider.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text('pick_image_widget.photo_library'.tr()),
                onTap: () {
                  _pickImageGalary();
                  Navigator.of(context).pop();
                },
              ),
              Divider(),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text('pick_image_widget.camera'.tr()),
                onTap: () {
                  _pickImageCamera();
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageGalary() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      setState(() {
        _image = file;
      });

      final menuProvider = Provider.of<MenuProvider>(context, listen: false);
      menuProvider.setPickedImage(file);
    }
  }

  Future<void> _pickImageCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final file = File(image.path);
      setState(() {
        _image = file;
      });

      final menuProvider = Provider.of<MenuProvider>(context, listen: false);
      menuProvider.setPickedImage(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = context.watch<MenuProvider>();
    return GestureDetector(
      onTap: () => _showPicker(context),

      child:
          menuProvider.pickedImage != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  menuProvider.pickedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 50,
                    color: AppColor.primaryColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "pick_image_widget.add_change_image".tr(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
    );
  }
}
