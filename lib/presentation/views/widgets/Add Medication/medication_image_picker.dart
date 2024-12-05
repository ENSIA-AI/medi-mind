import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medi_mind/themes/colors.dart';


class MedicationImagePicker extends StatelessWidget {
  final ValueNotifier<String?> imageController;
  final Function onImageSelected;
  const MedicationImagePicker({Key? key, required this.imageController, required this.onImageSelected})
      : super(key: key);

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery); // Open gallery

    if (pickedFile != null) {
      onImageSelected(pickedFile.path); // Update controller with image path
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Placeholder or current image
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: PRIMARY_BLUE,
                    borderRadius: BorderRadius.circular(24),

                  ),
                  child: ValueListenableBuilder<String?>(
                    valueListenable: imageController,
                    builder: (context, value, child) {
                      return value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(24),

                              child: Image.file(
                                File(value), // Show picked image
                                fit: BoxFit.cover,
                              ),
                            )
                          : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("assets/images/pills_add_medication_pic.png"),
                          );
                    },
                  ),
                ),
              ),

              // Floating Edit Button
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: TEXT_BEIGE,
                    child: SvgPicture.asset("assets/icons/modify_icon.svg",),
                  ),
                ),
              ),
            ],
          ),

          // Label Text

        ],
      ),
    );
  }
}
