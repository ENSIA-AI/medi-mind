import 'package:flutter/material.dart';

class MedicationTextFormField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller ;
  const MedicationTextFormField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text("Name" , style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20
    
          ),),
        ),
        SizedBox(height: 10,),
        Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 10,
          child: TextFormField(
            controller: controller,
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
