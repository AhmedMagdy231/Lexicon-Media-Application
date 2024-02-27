class CategoryDetailsModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  CategoryDetailsModel.formJson(Map<String, dynamic> json){
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
    if (json['data'] is Map) {
      data = Data.fromJson(json['data']);

    }
    else {
      data = null;
    }
  }
}


class Data {
  PagesCat? pagesCat;
  List<SubPagesCats>? subPagesCats;
  List<Pages>? pages;



  Data.fromJson(Map<String, dynamic> json) {
    pagesCat = json['pages_cat'] != null
        ? new PagesCat.fromJson(json['pages_cat'])
        : null;
    if (json['sub_pages_cats'] != null) {
      subPagesCats = <SubPagesCats>[];
      json['sub_pages_cats'].forEach((v) {
        subPagesCats!.add(new SubPagesCats.fromJson(v));
      });
    }
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
  }

}

class PagesCat {
  String? pAGESCATID;
  String? pARENTID;
  String? pagescatTitle;
  String? pagescatDescription;
  String? pagescatPhoto;
  String? pagescatActive;
  String? pagescatPriority;
  String? pagescatPages;



  PagesCat.fromJson(Map<String, dynamic> json) {
    pAGESCATID = json['PAGESCATID'];
    pARENTID = json['PARENTID'];
    pagescatTitle = json['pagescat_title'];
    pagescatDescription = json['pagescat_description'];
    pagescatPhoto = json['pagescat_photo'];
    pagescatActive = json['pagescat_active'];
    pagescatPriority = json['pagescat_priority'];
    pagescatPages = json['pagescat_pages'];
  }


}

class SubPagesCats {
  String? pAGESCATID;
  String? pARENTID;
  String? pagescatTitle;
  String? pagescatDescription;
  String? pagescatPhoto;
  String? pagescatActive;
  String? pagescatPriority;
  String? pagescatPages;



  SubPagesCats.fromJson(Map<String, dynamic> json) {
    pAGESCATID = json['PAGESCATID'];
    pARENTID = json['PARENTID'];
    pagescatTitle = json['pagescat_title'];
    pagescatDescription = json['pagescat_description'];
    pagescatPhoto = json['pagescat_photo'];
    pagescatActive = json['pagescat_active'];
    pagescatPriority = json['pagescat_priority'];
    pagescatPages = json['pagescat_pages'];
  }


}

class Pages {
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
  int? pageBookmarked;



  Pages.fromJson(Map<String, dynamic> json) {
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
    pageBookmarked = json['page_bookmarked'];
  }


}