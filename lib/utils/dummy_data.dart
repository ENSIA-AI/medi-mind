import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/intake.dart';
import 'package:medi_mind/data/model/medication.dart';
import 'package:medi_mind/data/model/reminder.dart';

List<String> days = ['Mon', 'Tus', 'Wes', 'The', 'Fri', 'Sat', 'Sun'];
List<String> valuesD = ['7', '6', '8', '9', '10 ', '11', '12'];
List<double> valuesC = [0.4, 0.9, 0.2, 0.8, 0, 0, 0];
List<bool> valuesP = [true, true, true, true, false, false, false];

Reminder rem1 = Reminder(
    id: "0",
    name: "Ibuprofen",
    selectedDays: [0,1],
    frequency: 2,
    form: "1 Pill",
    imageUrl: "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    intakes: [IntakeData.new(dose: 1, time: TimeOfDay.now())]
    );

Reminder rem2 = Reminder(
    id: "0",
    name: "Ibuprofen",
    selectedDays: [0,1],
    frequency: 2,
    form: "1 Pill",
    imageUrl: "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    intakes: [IntakeData.new(dose: 1, time: TimeOfDay.now())]
    );




List<Reminder> reminders = [
  Reminder(
    id: "1",
    name: "Doliprane 50mg",
    frequency: 2,
    form: "Pill(s)",
    imageUrl: "https://www.medicament.com/20187/doliprane-24-sirop-enfant-100-ml.jpg",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 08, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 20, minute: 00), dose: 1)
    ],
    selectedDays: [1, 3, 5]
  ),
  Reminder(
    id: "2",
    name: "Ibuprofen 200mg",
    frequency: 3,
    form: "Tablet(s)",
    imageUrl: "https://www.mpulsehealth.com/wp-content/uploads/2020/12/0904-6747-80_Ibuprofen_200mg_Tab_1000.jpg",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 08, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 14, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 20, minute: 00), dose: 1)
    ],
    selectedDays: [0, 2, 4]
  ),
  Reminder(
    id: "3",
    name: "Cough Syrup 150ml",
    frequency: 2,
    form: "Liquid",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBnAVKSmF85mlUFydDJ2RI4XydwTzJocssUA&s",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 10, minute: 00), dose: 15),
      IntakeData(time: TimeOfDay(hour: 22, minute: 00), dose: 15)
    ],
    selectedDays: [1, 3, 5]
  ),
  Reminder(
    id: "4",
    name: "Vitamin C 500mg",
    frequency: 1,
    form: "Chewable Tablet",
    imageUrl: "https://www.sasa.com/cdn/shop/products/106338203001-1.jpg?v=1656042009",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 08, minute: 30), dose: 1)
    ],
    selectedDays: [0, 6]
  ),
  Reminder(
    id: "5",
    name: "Paracetamol 500mg",
    frequency: 3,
    form: "Pill(s)",
    imageUrl: "https://www.medicinedirect.co.uk/media/catalog/product/cache/8bf3693ed458c257f5171ffffa4e8921/p/a/paracetamol_500_tablet_buy_medicine_direct_uk_parmacy_10.jpg",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 08, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 14, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 20, minute: 00), dose: 1)
    ],
    selectedDays: [0, 2, 4]
  ),
  Reminder(
    id: "6",
    name: "Antibiotic A500",
    frequency: 2,
    form: "Capsule(s)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7VsFQruTyfTVVMUd-pSGusGUnLpvzFBhVVw&s",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 09, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 21, minute: 00), dose: 1)
    ],
    selectedDays: [1, 3, 5]
  ),
  Reminder(
    id: "7",
    name: "Insulin I20U",
    frequency: 2,
    form: "Injection",
    imageUrl: "https://assets.truemeds.in/Images/ProductImage/TM-INON2-003968/INSULATARD-HUMAN-40-IU-INJECTION-10-ML_1.webp?width=320",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 08, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 20, minute: 00), dose: 1)
    ],
    selectedDays: [2, 4, 6]
  ),
  Reminder(
    id: "8",
    name: "Eye Drops 5ml",
    frequency: 3,
    form: "Liquid",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfQiqjfcF5w-N9POXEkHk4tz57ZtMKoSkL-g&s",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 07, minute: 00), dose: 2),
      IntakeData(time: TimeOfDay(hour: 15, minute: 00), dose: 2),
      IntakeData(time: TimeOfDay(hour: 22, minute: 00), dose: 2)
    ],
    selectedDays: [1, 2, 3, 5]
  ),
  Reminder(
    id: "9",
    name: "Multivitamins",
    frequency: 1,
    form: "Capsule(s)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgVhFyzZuypIXE1KDO9s2h5HNWO2frC5iDGA&s",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 08, minute: 00), dose: 1)
    ],
    selectedDays: [0, 6]
  ),
  Reminder(
    id: "10",
    name: "Antacid 20mg",
    frequency: 2,
    form: "Tablet(s)",
    imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlT_gsHEcZdifnU03axBcNJMq09XCOhULxSA&s",
    intakes: [
      IntakeData(time: TimeOfDay(hour: 10, minute: 00), dose: 1),
      IntakeData(time: TimeOfDay(hour: 18, minute: 00), dose: 1)
    ],
    selectedDays: [1, 3, 5]
  ),
];


final List<Medication> medications_dummy = [
  Medication(
    id: 1,
    name: "Paracetamol",
    unit: "500 mg",
    imgPath:
        "https://cdn11.bigcommerce.com/s-n6ynrx6s4d/images/stencil/1280x1280/products/2377/4521/ibuprofen_tabs__60250.1648242731.jpg?c=1",
    reminderDays: 1,
    details: "Take after meals to reduce fever and pain.",
    endDate: DateTime.now().add(Duration(days: 30)),
  ),
  Medication(
    id: 2,
    name: "Ibuprofen",
    unit: "200 mg",
    imgPath:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlT_gsHEcZdifnU03axBcNJMq09XCOhULxSA&s",
    reminderDays: 3,
    details: "Use for inflammation and mild pain.",
    endDate: null,
  ),
  Medication(
    id: 3,
    name: "Amoxicillin",
    unit: "250 mg",
    imgPath:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfQiqjfcF5w-N9POXEkHk4tz57ZtMKoSkL-g&s",
    reminderDays: 7,
    details: "Complete the full course as prescribed.",
    endDate: DateTime.now().add(Duration(days: 14)),
  ),
  Medication(
    id: 4,
    name: "Vitamin D",
    unit: "1000 IU",
    imgPath:
        "https://assets.truemeds.in/Images/ProductImage/TM-INON2-003968/INSULATARD-HUMAN-40-IU-INJECTION-10-ML_1.webp?width=320",
    reminderDays: 2,
    details: "Take once daily with meals to improve bone health.",
    endDate: DateTime.now().add(Duration(days: 60)),
  ),
  Medication(
    id: 5,
    name: "Cetirizine",
    unit: "10 mg",
    imgPath:
        "https://www.medicinedirect.co.uk/media/catalog/product/cache/8bf3693ed458c257f5171ffffa4e8921/p/a/paracetamol_500_tablet_buy_medicine_direct_uk_parmacy_10.jpg",
    reminderDays: 5,
    details: "For allergy relief. Use as needed.",
    endDate: null,
  ),
];
