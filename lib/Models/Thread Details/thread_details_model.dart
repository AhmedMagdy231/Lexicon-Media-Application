class ThreadDetailsModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  ThreadDetailsModel.formJson(Map<String,dynamic> json){
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

class AllMessage {
  late String message;
  late String image;
  late int owner;

  AllMessage({required this.message,required this.image,required this.owner});
}

class Data {
  String? resultsTotal;
  int? pageCurrent;
  dynamic pagePrev;
  dynamic pageNext;
  int? pageMax;
  Thread? thread;
  List<ThreadsMessages>? threadsMessages;
  List<AllMessage> allMessage = [];



  Data.fromJson(Map<String, dynamic> json) {
    resultsTotal = json['resultsTotal'];
    pageCurrent = json['pageCurrent'];
    pagePrev = json['pagePrev'];
    pageNext = json['pageNext'];
    pageMax = json['pageMax'];
    thread =
    json['thread'] != null ? new Thread.fromJson(json['thread']) : null;
    if (json['threads_messages'] != null) {
      threadsMessages = <ThreadsMessages>[];
      json['threads_messages'].forEach((v) {
        var newMessage = ThreadsMessages.fromJson(v);
        allMessage.add(
          AllMessage(
              message: newMessage.messageText!,
              image: newMessage.studentPic!,
              owner: newMessage.messageOwner!,
          )
        );

        threadsMessages!.add(newMessage);
      });
    }
  }


}



class Thread {
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



  Thread.fromJson(Map<String, dynamic> json) {
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

class ThreadsMessages {
  String? mESSAGEID;
  String? tHREADID;
  String? sTUDENTID;
  String? messageText;
  String? messageTime;
  String? messageDate;
  String? studentName;
  String? studentPic;
  int? messageOwner;


  ThreadsMessages.fromJson(Map<String, dynamic> json) {
    mESSAGEID = json['MESSAGEID'];
    tHREADID = json['THREADID'];
    sTUDENTID = json['STUDENTID'];
    messageText = json['message_text'];
    messageTime = json['message_time'];
    messageDate = json['message_date'];
    studentName = json['student_name'];
    studentPic = json['student_pic'];
    messageOwner = json['message_owner'];
  }

}