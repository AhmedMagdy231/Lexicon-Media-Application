class JobsModel {

  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  JobsModel.formJson(Map<String,dynamic> json){
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
  List<StudentJobs> studentJobs =[];
  List<String> jobsList =[];



  Data.fromJson(Map<String, dynamic> json) {
    if (json['students_jobs'] != null) {
      studentJobs = <StudentJobs>[];
      jobsList =[];
      json['students_jobs'].forEach((v) {
        studentJobs.add(new StudentJobs.fromJson(v));
        jobsList.add(v['studentjob_name']);
      });
    }
  }

}

class StudentJobs {
  String? sTudentJOBID;
  String? studentjobName;
  String? studentjobStatus;


  StudentJobs.fromJson(Map<String, dynamic> json) {
    sTudentJOBID = json['STUDENTJOBID'];
    studentjobName = json['studentjob_name'];
    studentjobStatus = json['studentjob_status'];
  }


}