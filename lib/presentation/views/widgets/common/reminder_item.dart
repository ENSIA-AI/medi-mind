import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_mind/data/model/reminder.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/themes/styles.dart';

class ReminderItem extends StatelessWidget {
  final Reminder data;
  final Function onDismissed;
  final bool inverseStyle;
  const ReminderItem({super.key, required this.data, this.inverseStyle = false, required this.onDismissed});


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            onDismissed(data.id);
          },
          key: Key(data.id.toString()),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
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
            
            decoration: BoxDecoration(color: (!inverseStyle ? PRIMARY_BLUE : Colors.white)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        data.imageUrl,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      )),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:  20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${data.name}",
                              style: inverseStyle ? BLUE_SUBHEADING_TEXT_STYLE : BEIGE_SUBHEADING_TEXT_STYLE ,
                            ),
                            
                            Text(
                              "${data.intakes[0].dose} ${data.form}",
                              style: inverseStyle ? BLUE_REGULAR_TEXT_STYLE : WHITE_REGULAR_TEXT_STYLE ,
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.alarm,
                              color: inverseStyle ? PRIMARY_BLUE :Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(data.intakes[0].format24Hour(), style: inverseStyle ? BLUE_REGULAR_TEXT_STYLE : WHITE_REGULAR_TEXT_STYLE)
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
