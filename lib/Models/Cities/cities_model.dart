class CitiesModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  CitiesModel.formJson(Map<String, dynamic> json){
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
  List<Cities>? cities;
  List<String> citiesList=[];

  Data({this.cities});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];

      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
        citiesList.add(v['city_name']);
      });
      citiesList = citiesList.toSet().toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  late String cITYID;
  late String rEGIONID;
  late String cityName;
  late String cityActive;



  Cities.fromJson(Map<String, dynamic> json) {
    cITYID = json['CITYID'];
    rEGIONID = json['REGIONID'];
    cityName = json['city_name'];
    cityActive = json['city_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CITYID'] = this.cITYID;
    data['REGIONID'] = this.rEGIONID;
    data['city_name'] = this.cityName;
    data['city_active'] = this.cityActive;
    return data;
  }
}