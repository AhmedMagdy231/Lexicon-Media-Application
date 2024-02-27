class SearchModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  SearchModel.formJson(Map<String,dynamic> json){
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
  String? searchQuery;
  List<Pages>? pages;



  Data.fromJson(Map<String, dynamic> json) {
    searchQuery = json['search_query'];
    if (json['pages'] != null) {
      pages = <Pages>[];
      json['pages'].forEach((v) {
        pages!.add(new Pages.fromJson(v));
      });
    }
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