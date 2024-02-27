class HomeModel{

  late bool hasError;
  List<dynamic> errors =[];
  List<dynamic> messages=[];
  Data? data;



  HomeModel.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<Slides>? slides;
  Advertisement1? advertisement1;
  Advertisement1? advertisement2;
  Advertisement1? advertisement3;
  List<PagesCats>? pagesCats;
  List<NewPages>? newPages;
  late List<StudentsTops> students_tops =[];



  Data.fromJson(Map<String, dynamic> json) {

    json['students_tops'].forEach((element){
      students_tops.add(StudentsTops.fromJson(element));
    });

    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides!.add(new Slides.fromJson(v));
      });
    }
    advertisement1 = json['advertisement_1'] != null
        ? new Advertisement1.fromJson(json['advertisement_1'])
        : null;
    advertisement2 = json['advertisement_2'] != null
        ? new Advertisement1.fromJson(json['advertisement_2'])
        : null;
    advertisement3 = json['advertisement_3'] != null
        ? new Advertisement1.fromJson(json['advertisement_3'])
        : null;
    if (json['pages_cats'] != null) {
      pagesCats = <PagesCats>[];
      json['pages_cats'].forEach((v) {
        pagesCats!.add(new PagesCats.fromJson(v));
      });
    }

    if (json['new_pages'] != null) {
      newPages = <NewPages>[];
      json['new_pages'].forEach((v) {
        newPages!.add( NewPages.fromJson(v));
      });
    }
  }


}

class StudentsTops {
  String? sTUDENTTOPID;
  String? sTUDENTID;
  String? studenttopPoints;
  String? studentName;
  String? studentPic;


  StudentsTops.fromJson(Map<String, dynamic> json) {
    sTUDENTTOPID = json['STUDENTTOPID'];
    sTUDENTID = json['STUDENTID'];
    studenttopPoints = json['studenttop_points'];
    studentName = json['student_name'];
    studentPic = json['student_pic'];
  }


}

class Slides {
  String? sLIDEID;
  String? slideTitle;
  String? slideTitle2;
  String? slidePic;
  String? slideDetails;
  String? slideActive;
  String? slideUrl;


  Slides.fromJson(Map<String, dynamic> json) {
    sLIDEID = json['SLIDEID'];
    slideTitle = json['slide_title'];
    slideTitle2 = json['slide_title_2'];
    slidePic = json['slide_pic'];
    slideDetails = json['slide_details'];
    slideActive = json['slide_active'];
    slideUrl = json['slide_url'];
  }


}

class Advertisement1 {
  String? aDVID;
  String? advName;
  String? advType;
  String? advCode;
  String? advUrl;
  String? advPic;
  String? advActive;
  String? advNotes;
  String? advAction;



  Advertisement1.fromJson(Map<String, dynamic> json) {
    aDVID = json['ADVID'];
    advName = json['adv_name'];
    advType = json['adv_type'];
    advCode = json['adv_code'];
    advUrl = json['adv_url'];
    advPic = json['adv_pic'];
    advActive = json['adv_active'];
    advNotes = json['adv_notes'];
    advAction = json['adv_action'];
  }


}

class PagesCats {
  String? pageCatId;
  String? pARENTID;
  String? catTitle;
  String? catDescription;
  String? catPhoto;
  String? catActive;
  String? catPriority;
  String? catpagess;



  PagesCats.fromJson(Map<String, dynamic> json) {
    pageCatId = json['PAGESCATID'];
    pARENTID = json['PARENTID'];
    catTitle = json['pagescat_title'];
    catDescription = json['pagescat_description'];
    catPhoto = json['pagescat_photo'];
    catActive = json['pagescat_active'];
    catPriority = json['pagescat_priority'];
    catpagess = json['pagescat_pages'];
  }


}

class NewPages {
  String? pAGEID;
  String? pAGESCATID;
  String? pAGEPOSTID;
  String? pagePn;
  String? pageName;
  String? pageActive;
  String? pageNew;
  String? pageSale;
  String? pageUrl;
  String? pagePrice;
  String? pageNotes;
  String? pagePoints;
  String? pagePaintRate;
  String? pageDataFilename;
  String? pageUsageUrl;
  String? pagespostFilename;



  NewPages.fromJson(Map<String, dynamic> json) {
    pAGEID = json['PAGEID'];
    pAGESCATID = json['PAGESCATID'];
    pAGEPOSTID = json['PAGEPOSTID'];
    pagePn = json['page_pn'];
    pageName = json['page_name'];
    pageActive = json['page_active'];
    pageNew = json['page_new'];
    pageSale = json['page_sale'];
    pageUrl = json['page_url'];
    pagePrice = json['page_price'];
    pageNotes = json['page_notes'];
    pagePoints = json['page_points'];
    pagePaintRate = json['page_paint_rate'];
    pageDataFilename = json['page_data_filename'];
    pageUsageUrl = json['page_usage_url'];
    pagespostFilename = json['pagespost_filename'];
  }


}