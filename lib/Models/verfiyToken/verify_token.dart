class UserModel{
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  UserModel.formJson(Map<String,dynamic> json){
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
  String? newstudentsNotifications;
  String? new_threadstud_unread;
  Student? student;
  bool? profileComplete;




  Data({this.newstudentsNotifications, this.student});

  Data.fromJson(Map<String, dynamic> json) {
    new_threadstud_unread = json['new_threadstud_unread'];
    newstudentsNotifications = json['new_students_notifications'];
    profileComplete = json['profileComplete'];
    student = json['student'] != null
        ? new Student.fromJson(json['student'])
        : null;
  }


}

class Student {
  String? studentID;
  String? studentJobID;
  String? cITYID;
  String? rEGIONID;
  String? studentUniqueid;
  String? studentName;
  String? studentDescription;
  String? studentActive;
  String? studentPic;
  String? studentPhone;
  String? studentEmail;
  String? studentNationalid;
  String? studentBirthdate;
  String? studentAddress;
  String? studentTaxesid;
  String? studentTradeid;
  String? studentPoints;
  String? studentAccesstoken;
  String? studentAddTime;
  String? studentLoginTime;
  String? studentVcode;
  String? studentVcodeTime;
  String? studentUniversityID;
  String? student_firebase_accesstoken;



  Student.fromJson(Map<String, dynamic> json) {
    studentID = json['STUDENTID'];
    studentJobID = json['STUDENTJOBID'];

    cITYID = json['CITYID'];
    rEGIONID = json['REGIONID'];
    studentUniversityID = json['UNIVERSITYID'];
    studentUniqueid = json['student_uniqueid'];
    studentName = json['student_name'];
    studentDescription = json['student_description'];
    studentActive = json['student_active'];
    studentPic = json['student_pic'];
    studentPhone = json['student_phone'];
    studentEmail = json['student_email'];
    studentNationalid = json['student_nationalid'];
    studentBirthdate = json['student_birthdate'];
    studentAddress = json['student_address'];
    studentTaxesid = json['student_taxesid'];
    studentTradeid = json['student_tradeid'];
    studentPoints = json['student_points'];
    studentAccesstoken = json['student_accesstoken'];
    studentAddTime = json['student_add_time'];
    studentLoginTime = json['student_login_time'];
    studentVcode = json['student_vcode'];
    studentVcodeTime = json['student_vcode_time'];
    student_firebase_accesstoken = json['student_firebase_accesstoken'];
  }


}