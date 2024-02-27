class UniversitiesModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  UniversitiesModel.formJson(Map<String,dynamic> json){
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
  List<universitys> universities=[];
  List<String> universitiesNames =[];



  Data.fromJson(Map<String, dynamic> json) {
    if (json['universities'] != null) {

      json['universities'].forEach((v) {
        universities.add(new universitys.fromJson(v));
        universitiesNames.add(v['university_name']);

      });
    }
  }

}

class universitys {
  String? universityID;
  String? cITYID;
  String? rEGIONID;
  String? universityName;
  String? universityDescription;
  String? universityActive;
  String? universityPic;
  String? universityPhone;
  String? universityFax;
  String? universityEmail;
  String? universityMapX;
  String? universityMapY;
  String? universityLocation;
  String? universityPriority;
  String? universityPublished;
  String? universityUsername;
  String? universityPassword;
  String? universityTaxid;
  String? universityTradeid;
  String? universityManager;
  String? universityManagerPhone;
  String? universityMangerEmail;
  String? universityAccesstoken;
  String? cityName;
  String? cityActive;
  String? regionName;
  String? regionActive;


  universitys.fromJson(Map<String, dynamic> json) {
    universityID = json['UNIVERSITYID'];
    cITYID = json['CITYID'];
    rEGIONID = json['REGIONID'];
    universityName = json['university_name'];
    universityDescription = json['university_description'];
    universityActive = json['university_active'];
    universityPic = json['university_pic'];
    universityPhone = json['university_phone'];
    universityFax = json['university_fax'];
    universityEmail = json['university_email'];
    universityMapX = json['university_map_x'];
    universityMapY = json['university_map_y'];
    universityLocation = json['university_location'];
    universityPriority = json['university_priority'];
    universityPublished = json['university_published'];
    universityUsername = json['university_username'];
    universityPassword = json['university_password'];
    universityTaxid = json['university_taxid'];
    universityTradeid = json['university_tradeid'];
    universityManager = json['university_manager'];
    universityManagerPhone = json['university_manager_phone'];
    universityMangerEmail = json['university_manger_email'];
    universityAccesstoken = json['university_accesstoken'];
    cityName = json['city_name'];
    cityActive = json['city_active'];
    regionName = json['region_name'];
    regionActive = json['region_active'];
  }


}