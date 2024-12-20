import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:medi_mind/data/dbhelper/db_helper.dart';
import 'package:medi_mind/data/model/medication.dart';

import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_image_picker.dart';
import 'package:medi_mind/presentation/views/widgets/Add%20Medication/medication_text_form_field.dart';
import 'package:medi_mind/presentation/views/widgets/common/action_button.dart';
import 'package:medi_mind/presentation/views/widgets/common/app_barV2.dart';
import 'package:medi_mind/themes/styles.dart';
import 'package:medi_mind/utils/toast_message.dart';

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
  late ValueNotifier<Uint8List?> imageController;
  late TextEditingController nameController;
  late TextEditingController detailsController;
  late ValueNotifier<bool> isModifiedNotifier;

  final DbHelper _dbHelper = DbHelper();

  void updateImage(Uint8List? path) {
    if (path != null && path != widget.medicationData.img) {
      imageController.value = path;
      isModifiedNotifier.value = true;
    }
  }

  @override
  void initState() {
    super.initState();
    imageController = ValueNotifier(widget.medicationData.img);
    nameController = TextEditingController(text: widget.medicationData.name);
    detailsController =
        TextEditingController(text: widget.medicationData.details);
    isModifiedNotifier = ValueNotifier(false);

    nameController.addListener(_checkForChanges);
    detailsController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    if (nameController.text != widget.medicationData.name ||
        detailsController.text != (widget.medicationData.details ?? "") ||
        (imageController.value ?? "") != (widget.medicationData.img ?? "")) {
      isModifiedNotifier.value = true;
    } else {
      isModifiedNotifier.value = false;
    }
  }

  Future<void> _saveMedication() async {
    

    var db = await _dbHelper.database;
    await db.update('medications', {
      'name' : nameController.text,
      'details' : detailsController.text,
      'img' : imageController.value
    }, where: 'id = ?' , whereArgs: [widget.medicationData.id]);

    ShowToastMessage("Updated Medication Successfully");
    Navigator.popUntil(context, ModalRoute.withName('/main'));
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
              const SizedBox(height: 20),
              MedicationTextFormField(
                label: "Name",
                placeholder: "E.g. Ibuprofen, ...",
                controller: nameController,
              ),
              const SizedBox(height: 20),
              MedicationTextFormField(
                label: "Details",
                placeholder: "E.g. Before Meal, With water, ...",
                controller: detailsController,
                longText: true,
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: isModifiedNotifier,
                builder: (context, isModified, child) {
                  return isModified
                      ? ActionButton(
                          text: "Save",
                          onPressed: _saveMedication,
                          style: PRIMARY_ACTION_BUTTON_STYLE,
                          textStyle: SECONDARY_ACTION_BUTTON_TEXT_STYLE,
                        )
                      : const SizedBox
                          .shrink(); // Do not show the button if not modified
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
