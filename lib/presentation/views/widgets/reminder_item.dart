import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class ReminderItem extends StatelessWidget {
  final Reminder data;
  const ReminderItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {},
          key: Key(data.id.toString()),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red.shade400,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            height: 200,
            decoration: const BoxDecoration(color: PRIMARY_BLUE),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        data.imageUrl,
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${data.name} , ${data.dosage}",
                      style: BEIGE_SUBHEADING_TEXT_STYLE,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data.form}, ${data.frequency}",
                      style: WHITE_REGULAR_TEXT_STYLE,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.alarm,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(data.time, style: WHITE_REGULAR_TEXT_STYLE)
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
