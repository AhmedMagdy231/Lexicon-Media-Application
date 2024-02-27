class PageDetailsModel {
  late bool hasError;
  late List<dynamic> errors;
  late List<dynamic> messages;
  late Data? data;

  PageDetailsModel.formJson(Map<String, dynamic> json){
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
  Page? page;
  List<PagesPosts>? pagesPosts;
  List<DownloadablePagesFiles>? downloadablePagesFiles;
  List<AudioPagesFiles>? audioPagesFiles;
  List<YoutubePagesUrls>? youtubePagesUrls;
  List<ExternalPagesUrls>? externalPagesUrls;
  List<VideoPagesFiles>? videoPagesFiles;



  Data.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new Page.fromJson(json['page']) : null;
    if (json['pages_posts'] != null) {
      pagesPosts = <PagesPosts>[];
      json['pages_posts'].forEach((v) {
        pagesPosts!.add(new PagesPosts.fromJson(v));
      });
    }
    if (json['downloadable_pages_files'] != null) {
      downloadablePagesFiles = <DownloadablePagesFiles>[];
      json['downloadable_pages_files'].forEach((v) {
        downloadablePagesFiles!.add(new DownloadablePagesFiles.fromJson(v));
      });
    }
    if (json['audio_pages_files'] != null) {
      audioPagesFiles = <AudioPagesFiles>[];
      json['audio_pages_files'].forEach((v) {

        audioPagesFiles!.add( AudioPagesFiles.fromJson(v));
      });
    }

    if (json['youtube_pages_urls'] != null) {
      youtubePagesUrls = <YoutubePagesUrls>[];
      json['youtube_pages_urls'].forEach((v) {
        youtubePagesUrls!.add(new YoutubePagesUrls.fromJson(v));
      });
    }


    if (json['external_pages_urls'] != null) {
      externalPagesUrls = <ExternalPagesUrls>[];
      json['external_pages_urls'].forEach((v) {
        externalPagesUrls!.add(new ExternalPagesUrls.fromJson(v));
      });
    }

    if (json['video_pages_files'] != null) {
      videoPagesFiles = <VideoPagesFiles>[];
      json['video_pages_files'].forEach((v) {
        videoPagesFiles!.add(new VideoPagesFiles.fromJson(v));
      });
    }

  }


}

class Page {
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
  String? pageDescription;
  String? pageNotes;
  String? pagePoints;
  String? pagePaintRate;
  String? pageDataFilename;
  String? pageUsageUrl;
  String? pagespostFilename;
  int? pageBookMarked;



  Page.fromJson(Map<String, dynamic> json) {
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
    pageDescription = json['page_description'];
    pageNotes = json['page_notes'];
    pagePoints = json['page_points'];
    pagePaintRate = json['page_paint_rate'];
    pageDataFilename = json['page_data_filename'];
    pageUsageUrl = json['page_usage_url'];
    pagespostFilename = json['pagespost_filename'];
    pageBookMarked = json['page_bookmarked'];

  }

}

class PagesPosts {
 dynamic pAGEPOSTID;
  String? pagespostTitle;
  String? pagespostFilename;
  dynamic pagespostCover;



  PagesPosts.fromJson(Map<String, dynamic> json) {
    pAGEPOSTID = json['PAGEPOSTID'];
    pagespostTitle = json['pagespost_title'];
    pagespostFilename = json['pagespost_filename'];
    pagespostCover = json['pagespost_cover'];
  }

}

class DownloadablePagesFiles {
  String? pAGESFILEID;
  String? pAGEID;
  String? pagesfileTitle;
  String? pagesfileFilename;
  String? pagesfileType;
  String? pagesfileStatus;
  String? pagesfileOrder;
  String? pagesfileViews;
  String? pagesfileAudio;
  String? pagesfileVideo;



  DownloadablePagesFiles.fromJson(Map<String, dynamic> json) {
    pAGESFILEID = json['PAGESFILEID'];
    pAGEID = json['PAGEID'];
    pagesfileTitle = json['pagesfile_title'];
    pagesfileFilename = json['pagesfile_filename'];
    pagesfileType = json['pagesfile_type'];
    pagesfileStatus = json['pagesfile_status'];
    pagesfileOrder = json['pagesfile_order'];
    pagesfileViews = json['pagesfile_views'];
    pagesfileAudio = json['pagesfile_audio'];
    pagesfileVideo = json['pagesfile_video'];
  }


}


class AudioPagesFiles {
  String? pAGESFILEID;
  String? pAGEID;
  String? pagesfileTitle;
  String? pagesfileFilename;
  String? pagesfileType;
  String? pagesfileStatus;
  String? pagesfileOrder;
  String? pagesfileViews;
  String? pagesfileAudio;
  String? pagesfileVideo;



  AudioPagesFiles.fromJson(Map<String, dynamic> json) {
    pAGESFILEID = json['PAGESFILEID'];
    pAGEID = json['PAGEID'];
    pagesfileTitle = json['pagesfile_title'];
    pagesfileFilename = json['pagesfile_filename'];
    pagesfileType = json['pagesfile_type'];
    pagesfileStatus = json['pagesfile_status'];
    pagesfileOrder = json['pagesfile_order'];
    pagesfileViews = json['pagesfile_views'];
    pagesfileAudio = json['pagesfile_audio'];
    pagesfileVideo = json['pagesfile_video'];
  }


}

class ExternalPagesUrls {
  String? pAGESURLID;
  String? pAGEID;
  String? pagesurlValue;
  String? pagesurlTitle;
  String? pagesurlType;
  String? pagesurlStatus;
  String? pagesurlOrder;
  String? pagesurlViews;



  ExternalPagesUrls.fromJson(Map<String, dynamic> json) {
    pAGESURLID = json['PAGESURLID'];
    pAGEID = json['PAGEID'];
    pagesurlValue = json['pagesurl_value'];
    pagesurlTitle = json['pagesurl_title'];
    pagesurlType = json['pagesurl_type'];
    pagesurlStatus = json['pagesurl_status'];
    pagesurlOrder = json['pagesurl_order'];
    pagesurlViews = json['pagesurl_views'];
  }


}

class YoutubePagesUrls {
  String? pAGESURLID;
  String? pAGEID;
  String? pagesurlValue;
  String? pagesurlTitle;
  String? pagesurlType;
  String? pagesurlStatus;
  String? pagesurlOrder;
  String? pagesurlViews;

  YoutubePagesUrls(
      {this.pAGESURLID,
        this.pAGEID,
        this.pagesurlValue,
        this.pagesurlTitle,
        this.pagesurlType,
        this.pagesurlStatus,
        this.pagesurlOrder,
        this.pagesurlViews});

  YoutubePagesUrls.fromJson(Map<String, dynamic> json) {
    pAGESURLID = json['PAGESURLID'];
    pAGEID = json['PAGEID'];
    pagesurlValue = json['pagesurl_value'];
    pagesurlTitle = json['pagesurl_title'];
    pagesurlType = json['pagesurl_type'];
    pagesurlStatus = json['pagesurl_status'];
    pagesurlOrder = json['pagesurl_order'];
    pagesurlViews = json['pagesurl_views'];
  }


}

class VideoPagesFiles {
  String? pAGESFILEID;
  String? pAGEID;
  String? pagesfileTitle;
  String? pagesfileFilename;
  String? pagesfileType;
  String? pagesfileStatus;
  String? pagesfileOrder;
  String? pagesfileViews;
  String? pagesfileAudio;
  String? pagesfileVideo;



  VideoPagesFiles.fromJson(Map<String, dynamic> json) {
    pAGESFILEID = json['PAGESFILEID'];
    pAGEID = json['PAGEID'];
    pagesfileTitle = json['pagesfile_title'];
    pagesfileFilename = json['pagesfile_filename'];
    pagesfileType = json['pagesfile_type'];
    pagesfileStatus = json['pagesfile_status'];
    pagesfileOrder = json['pagesfile_order'];
    pagesfileViews = json['pagesfile_views'];
    pagesfileAudio = json['pagesfile_audio'];
    pagesfileVideo = json['pagesfile_video'];
  }


}

