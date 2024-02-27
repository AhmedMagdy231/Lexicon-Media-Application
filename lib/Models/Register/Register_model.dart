class RegisterModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  RegisterModel.formJson(Map<String,dynamic> json){
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
    if(json['data'] is Map)
    {
      data = Data.fromJson(json['data']);
    }
    else
    {
      data = null;
    }

  }

}

class Data {
  String? studentUniqueid;
  Data({this.studentUniqueid});

  Data.fromJson(Map<String, dynamic> json) {
    studentUniqueid = json['student_uniqueid'];
  }


}