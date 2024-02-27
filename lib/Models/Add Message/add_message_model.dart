class AddMessageModel {
  bool? hasError;
  List? errors;
  List? messages;




  AddMessageModel.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
  }

}