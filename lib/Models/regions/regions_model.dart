class RegionsModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  RegionsModel.formJson(Map<String,dynamic> json){
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
  List<Regions> regions=[];
  List<String> regionsList=[];

  Data.fromJson(Map<String, dynamic> json) {
    if (json['regions'] != null) {
      json['regions'].forEach((v) {
        regions.add(Regions.fromJson(v));
        regionsList.add(v['region_name']);
      });

      regionsList = regionsList.toSet().toList();
    }
  }


}

class Regions {
  late String rEGIONID;
  late String regionName;
  late String regionActive;


  Regions.fromJson(Map<String, dynamic> json) {
    rEGIONID = json['REGIONID'];
    regionName = json['region_name'];
    regionActive = json['region_active'];
  }


}