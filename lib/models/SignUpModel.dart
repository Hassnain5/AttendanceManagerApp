

class SignUpModel {
  String id;
  String name;
  String sClass;
  String email;
  String contactNumber;
  String password;
  SignUpModel({
    required this.id,
    required this.name,
    required this.sClass, required this.email,
    required this.contactNumber,
    required this.password, });


  Map<String, dynamic> toMap(){
    return{
      "Name" : name,
      "Email" : email,
      "ContactNumber" : contactNumber,
      "Class" : sClass,
    };
  }

  factory SignUpModel.fromMap(Map<String, dynamic>map, String documentId, String passw){
    return SignUpModel(
      id: documentId,
        name: map["Name"] ?? "",
        sClass: map["Class"] ?? "",
        email: map["Email"] ?? "",
        contactNumber: map["contactNumber"] ?? "",
        password: passw);
  }

}
