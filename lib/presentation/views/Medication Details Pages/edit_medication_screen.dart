import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_image_picker.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_text_form_field.dart';
import 'package:medi_mind/presentation/views/widgets/common/action_button.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/themes/styles.dart';

class EditMedicationScreen extends StatefulWidget {
  final Medication medicationData; 
  const EditMedicationScreen({
    super.key,
    required this.medicationData,
  });

  @override
  State<EditMedicationScreen> createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  late ValueNotifier<String?> imageController;
  late TextEditingController nameController;
  late TextEditingController detailsController;
  late ValueNotifier<bool> isModifiedNotifier;

  void updateImage(String? path) {
    if (path != null && path != widget.medicationData.imgPath) {
      imageController.value = path;
      isModifiedNotifier.value = true;
    }
  }

  @override
  void initState() {
    super.initState();
    imageController = ValueNotifier(widget.medicationData.imgPath);
    nameController = TextEditingController(text: widget.medicationData.name);
    detailsController = TextEditingController(text: widget.medicationData.details);
    isModifiedNotifier = ValueNotifier(false);

    nameController.addListener(_checkForChanges);
    detailsController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    
    if (nameController.text != widget.medicationData.name ||
        detailsController.text != (widget.medicationData.details ?? "")) {
      isModifiedNotifier.value = true;
      
    } else if ((imageController.value ?? "") == (widget.medicationData.imgPath ?? "")) {
      isModifiedNotifier.value = false;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    detailsController.dispose();
    isModifiedNotifier.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarV2(pageTitle: "Edit Medication"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MedicationImagePicker(
                imageController: imageController,
                onImageSelected: updateImage,
              ),
              SizedBox(height: 20),
              MedicationTextFormField(
                label: "Name",
                placeholder: "E.g. Ibuprofen, ...",
                controller: nameController,
              ),
              SizedBox(height: 20),
              MedicationTextFormField(
                label: "Details",
                placeholder: "E.g. Before Meal, With water, ...",
                controller: detailsController,
                longText: true,
              ),
              SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: isModifiedNotifier,
                builder: (context, isModified, child) {
                  return isModified
                      ? ActionButton(text: "Save", onPressed: (){
                        Navigator.pop(context);
                      }, style: PRIMARY_ACTION_BUTTON_STYLE, textStyle: SECONDARY_ACTION_BUTTON_TEXT_STYLE)
                      : SizedBox.shrink(); // Do not show the button if not modified
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
