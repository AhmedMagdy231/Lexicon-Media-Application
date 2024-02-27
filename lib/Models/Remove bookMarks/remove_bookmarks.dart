class RemoveBookMarksModel {
  bool? hasError;
  List? errors;
  List? messages;




  RemoveBookMarksModel.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
  }

}