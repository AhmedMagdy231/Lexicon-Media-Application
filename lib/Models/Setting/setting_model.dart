class SettingUrlModel{
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  SettingUrlModel.formJson(Map<String, dynamic> json) {
    hasError = json['hasError'];
    errors = json['errors'];
    messages = json['messages'];
    if (json['data'] is Map) {
      data = Data.fromJson(json['data']);
    } else {
      data = null;
    }
  }
}

class Data {
  String? websiteContactWebsite;
  String? websiteContactEmail;
  String? websiteContactPhone;
  String? websiteContactFax;
  String? websiteContactWhatspp;
  String? websiteContactAddress;
  String? websiteContactAddress2;
  String? websiteContactMapsX;
  String? websiteContactMapsY;
  String? websiteSocialFacebookUrl;
  String? websiteSocialTwitterUrl;
  String? websiteSocialInstagramUrl;
  String? websiteSocialYoutubeUrl;
  String? websiteSocialLinkedinUrl;
  String? websiteSocialPinterestUrl;
  String? system_zendesk_enabled;
  String? system_zendesk_key_android;
  String? system_zendesk_key_ios;




  Data.fromJson(Map<String, dynamic> json) {
    websiteContactWebsite = json['website_contact_website'];
    websiteContactEmail = json['website_contact_email'];
    websiteContactPhone = json['website_contact_phone'];
    websiteContactFax = json['website_contact_fax'];
    websiteContactWhatspp = json['website_contact_whatspp'];
    websiteContactAddress = json['website_contact_address'];
    websiteContactAddress2 = json['website_contact_address_2'];
    websiteContactMapsX = json['website_contact_maps_x'];
    websiteContactMapsY = json['website_contact_maps_y'];
    websiteSocialFacebookUrl = json['website_social_facebook_url'];
    websiteSocialTwitterUrl = json['website_social_twitter_url'];
    websiteSocialInstagramUrl = json['website_social_instagram_url'];
    websiteSocialYoutubeUrl = json['website_social_youtube_url'];
    websiteSocialLinkedinUrl = json['website_social_linkedin_url'];
    websiteSocialPinterestUrl = json['website_social_pinterest_url'];
    system_zendesk_enabled  = json['system_zendesk_enabled'];
    system_zendesk_key_android = json['system_zendesk_key_android'];
    system_zendesk_key_ios = json['system_zendesk_key_ios'];

  }

}
