class CategoryModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  CategoryModel.formJson(Map<String,dynamic> json){
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
    if(json['data'] is Map)
    {
      data = Data.formJson(json['data']);
    }
    else
    {
      data = null;
    }

  }

}




class Data {

  List<DataCategory> pages_cat =[];


  Data.formJson(Map<String,dynamic> json){

    json['pages_cats'].forEach((element){
      pages_cat.add(DataCategory.fromJson(element));
    });


  }
}

class DataCategory{

  late String CID;
  late String PARENTID;
  late String cat_title;
  late String cat_description;
  late String  cat_photo;
  late String  cat_active;
  late String cat_priority;
  late String cat_pages;
  late String pagescat_icon;

  DataCategory.fromJson(Map<String,dynamic> json){
    CID = json['PAGESCATID'];
    PARENTID = json['PARENTID'];
    cat_title = json['pagescat_title'];
    cat_description = json['pagescat_description'];
    cat_photo = json['pagescat_photo'];
    cat_active = json['pagescat_active'];
    cat_priority = json['pagescat_priority'];
    cat_pages = json['pagescat_pages'];
    pagescat_icon = json['pagescat_icon'];

  }

}

