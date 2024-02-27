class ForgetPasswordModel{
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  ForgetPasswordModel.formJson(Map<String,dynamic> json){
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
  String? student_uniqueid ;



  Data.fromJson(Map<String, dynamic> json) {
    student_uniqueid = json['student_uniqueid'];
  }


}