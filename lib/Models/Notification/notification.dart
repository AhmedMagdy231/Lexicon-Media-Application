class NotificationModel{
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  NotificationModel.formJson(Map<String,dynamic> json){
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
  String? resultsTotal;
  int? pageCurrent;
  int? pageMax;
  List<StudentsNotifications>? studentsNotifications;


  Data.fromJson(Map<String, dynamic> json) {
    resultsTotal = json['resultsTotal'];
    pageCurrent = json['pageCurrent'];
    pageMax = json['pageMax'];
    if (json['students_notifications'] != null) {
      studentsNotifications = <StudentsNotifications>[];
      json['students_notifications'].forEach((v) {
        studentsNotifications!.add(new StudentsNotifications.fromJson(v));
      });
    }
  }


}

class StudentsNotifications {
  String? sTUDNOTIFICATIONID;
  String? sTUDENTID;
  String? studnotificationMessage;
  String? studnotificationTime;
  String? studnotificationDate;
  String? studnotificationRead;
  String? studnotificationAction;
  String? studnotificationIcon;
  String? studnotificationActionId;


  StudentsNotifications.fromJson(Map<String, dynamic> json) {

    sTUDNOTIFICATIONID = json['STUDNOTIFICATIONID'];
    sTUDENTID = json['STUDENTID'];
    studnotificationMessage = json['studnotification_message'];
    studnotificationTime = json['studnotification_time'];
    studnotificationDate = json['studnotification_date'];
    studnotificationRead = json['studnotification_read'];
    studnotificationAction = json['studnotification_action'];
    studnotificationIcon = json['studnotification_icon'];
    studnotificationActionId = json['studnotification_action_id'];
  }


}