class ProfileModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  ProfileModel.formJson(Map<String,dynamic> json){
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
  Student? student;

  Data({this.student});

  Data.fromJson(Map<String, dynamic> json) {
    student =
    json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

}

class Student {
  String? sTUDENTID;
  String? sTUDENTJOBID;
  String? rEGIONID;
  String? uNIVERSITYID;
  String? studentUniqueid;
  String? studentPassword;
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
  String? studentResetVcode;
  String? studentResetVcodeTime;
  String? studentFirebaseAccesstoken;


  Student.fromJson(Map<String, dynamic> json) {
    sTUDENTID = json['STUDENTID'];
    sTUDENTJOBID = json['STUDENTJOBID'];
    rEGIONID = json['REGIONID'];
    uNIVERSITYID = json['UNIVERSITYID'];
    studentUniqueid = json['student_uniqueid'];
    studentPassword = json['student_password'];
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
    studentResetVcode = json['student_reset_vcode'];
    studentResetVcodeTime = json['student_reset_vcode_time'];
    studentFirebaseAccesstoken = json['student_firebase_accesstoken'];
  }


}