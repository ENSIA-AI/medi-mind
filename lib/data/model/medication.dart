class Medication {

  final String id;
  final String name;
  final String type;
  final int dose;
  final String picpath;
  final String desc;

  Medication ({required this.id, 
              required this.name, 
              required this.type, 
              required this.dose, 
              required this.picpath,
              this.desc = 'no description provided',
              });

//conversion methods 

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      dose: json['dose'] as int,
      picpath: json['picturePath'] as String,
      desc: json['description'] as String,
    );
  }

  /// Method to convert a Reminder instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'dose': dose,
      'picturePath': picpath,
      'description': desc,

    };            
  
}

}