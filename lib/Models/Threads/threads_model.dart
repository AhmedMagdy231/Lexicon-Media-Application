class ThreadsModel{
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  ThreadsModel.formJson(Map<String,dynamic> json){
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
  dynamic pagePrev;
  dynamic pageNext;
  int? pageMax;
  List<Threads>? threads;



  Data.fromJson(Map<String, dynamic> json) {
    resultsTotal = json['resultsTotal'];
    pageCurrent = json['pageCurrent'];
    pagePrev = json['pagePrev'];
    pageNext = json['pageNext'];
    pageMax = json['pageMax'];
    if (json['threads'] != null) {
      threads = <Threads>[];
      json['threads'].forEach((v) {
        threads!.add(new Threads.fromJson(v));
      });
    }
  }


}

class Threads {
  String? tHREADID;
  String? sTARTERID;
  String? pAGEID;
  String? threadTopic;
  String? threadTime;
  String? threadDate;
  String? starterName;
  String? starterPic;
  String? tHREADSTUDID;
  String? sTUDENTID;
  String? threadstudUnread;
  String? threadstudLastactiveTime;
  String? threadstudLastactiveDate;



  Threads.fromJson(Map<String, dynamic> json) {
    tHREADID = json['THREADID'];
    sTARTERID = json['STARTERID'];
    pAGEID = json['PAGEID'];
    threadTopic = json['thread_topic'];
    threadTime = json['thread_time'];
    threadDate = json['thread_date'];
    starterName = json['starter_name'];
    starterPic = json['starter_pic'];
    tHREADSTUDID = json['THREADSTUDID'];
    sTUDENTID = json['STUDENTID'];
    threadstudUnread = json['threadstud_unread'];
    threadstudLastactiveTime = json['threadstud_lastactive_time'];
    threadstudLastactiveDate = json['threadstud_lastactive_date'];
  }

}