class BookMarksModel{

  late bool hasError;
  List<dynamic> errors =[];
  List<dynamic> messages=[];
  Data? data;



  BookMarksModel.fromJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? resultsTotal;
  int? pageCurrent;
  dynamic pagePrev;
  dynamic pageNext;
  int? pageMax;
  List<PagesBookmarks>? pagesBookmarks;



  Data.fromJson(Map<String, dynamic> json) {
    resultsTotal = json['resultsTotal'];
    pageCurrent = json['pageCurrent'];
    pagePrev = json['pagePrev'];
    pageNext = json['pageNext'];
    pageMax = json['pageMax'];
    if (json['pages_bookmarks'] != null) {
      pagesBookmarks = <PagesBookmarks>[];
      json['pages_bookmarks'].forEach((v) {
        pagesBookmarks!.add(new PagesBookmarks.fromJson(v));
      });
    }
  }


}

class PagesBookmarks {
  String? bOOKMARKID;
  String? pAGEID;
  String? sTUDENTID;
  String? pAGESCATID;
  String? pAGEPOSTID;
  String? pagePn;
  String? pageName;
  String? pageActive;
  String? pageNew;
  String? pageSale;
  String? pageUrl;
  String? pagePrice;
  String? pageDescription;
  String? pageNotes;
  String? pagePoints;
  String? pagePaintRate;
  String? pageDataFilename;
  String? pageUsageUrl;


  PagesBookmarks.fromJson(Map<String, dynamic> json) {
    bOOKMARKID = json['BOOKMARKID'];
    pAGEID = json['PAGEID'];
    sTUDENTID = json['STUDENTID'];
    pAGESCATID = json['PAGESCATID'];
    pAGEPOSTID = json['PAGEPOSTID'];
    pagePn = json['page_pn'];
    pageName = json['page_name'];
    pageActive = json['page_active'];
    pageNew = json['page_new'];
    pageSale = json['page_sale'];
    pageUrl = json['page_url'];
    pagePrice = json['page_price'];
    pageDescription = json['page_description'];
    pageNotes = json['page_notes'];
    pagePoints = json['page_points'];
    pagePaintRate = json['page_paint_rate'];
    pageDataFilename = json['pagespost_filename'];
    pageUsageUrl = json['page_usage_url'];
  }


}