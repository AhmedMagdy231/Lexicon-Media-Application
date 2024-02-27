class AddBookMarksModel {
  bool? hasError;
  List? errors;
  List? messages;




  AddBookMarksModel.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
  }

}