import 'package:flutter/material.dart';
import 'package:medi_mind/themes/colors.dart';

class MedicationTextFormField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller ;
  final bool longText;
  final Function? onChange;
  const MedicationTextFormField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.onChange = null,
    this.longText = false    
    
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(label , style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: PRIMARY_BLUE
          ),),
        ),
        SizedBox(height: 5,),
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: TextFormField(
            maxLines: (longText) ? 3 : 1,
            minLines: (longText) ? 3 : 1,
            controller: controller,
            onChanged: (value){
              if(onChange != null) onChange!(value);
            },
            validator: (value) {
              if(value == null || value.isEmpty ){
                return "Provide a name!";
              }
            },
            style: TextStyle(
              fontSize: 20
            ),
            decoration: InputDecoration(

              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              hintText: placeholder,
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              border: OutlineInputBorder(

                borderRadius: BorderRadius.circular(20)
              ),

            ),
          ),
        )
      ],
    );
  }
}
