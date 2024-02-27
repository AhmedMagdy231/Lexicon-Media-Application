
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:education_application/Cubits/Auth%20Cubit/auth_cubit.dart';
import 'package:education_application/Models/Add%20BookMarkes/add_book_markes.dart';
import 'package:education_application/Models/BookMarks/bookMarks.dart';
import 'package:education_application/Models/Category%20Details/category_details.dart';
import 'package:education_application/Models/Home/home_model.dart';
import 'package:education_application/Models/Page%20Details/page_details.dart';
import 'package:education_application/Models/Remove%20bookMarks/remove_bookmarks.dart';
import 'package:education_application/Models/Search%20Model/search_model.dart';
import 'package:education_application/Models/Threads/threads_model.dart';
import 'package:education_application/Models/Universities/center_model.dart';
import 'package:education_application/Models/jobs/jobs_model.dart';
import 'package:education_application/Models/profile/profile_model.dart';
import 'package:education_application/Models/regions/regions_model.dart';
import 'package:education_application/Network/Local/CashHelper.dart';
import 'package:education_application/Network/Local/Database/database.dart';
import 'package:education_application/Screens/Categories/categories_screen.dart';
import 'package:education_application/Screens/Home/home_screen.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Constant/Varibles/variables.dart';
import '../../Models/Add Message/add_message_model.dart';
import '../../Models/Categories/categoryProductsModel.dart';
import '../../Models/Delete Account/delete_account.dart';
import '../../Models/Forget Passwrod/forget_password_model.dart';
import '../../Models/Note/note.dart';
import '../../Models/Notification Read/notification_read_model.dart';
import '../../Models/Notification/notification.dart';
import '../../Models/Thread Details/thread_details_model.dart';
import '../../Models/verfiyToken/verify_token.dart';
import '../../Network/Remote/dio_helper.dart';
import '../../Network/endPoind.dart';
import '../../Screens/Audios/page_details_audio.dart';
import '../../Screens/Images/page_details_Images.dart';
import '../../Screens/Notes/notes.dart';
import '../../Screens/Pdf/page_details_pdf.dart';
import '../../Screens/Profile/profile.dart';
import 'package:http_parser/http_parser.dart';

import '../../Screens/Reference Screen/reference_screen.dart';
import '../../Screens/Setting/Settings.dart';
import '../../Screens/Videos/video_details.dart';
import '../../Screens/Youtube Videos/page_details_videos.dart';


part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  int indexScreen =0;
  List<Widget> myScreens = [
    HomeScreen(),
    CategoriesScreen(),
    NotesScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];

  String language = 'ar';
  bool isArabic = true;
  int  yourActiveIndexSlider = 0;
  File? image;

  var searchController  = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var regionController = TextEditingController();
  var universityController = TextEditingController();
  var birthdateController = TextEditingController();
  var jobController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  HomeModel? homeModel;
  UserModel? userModel;
  CategoryModel? categoryModel;
  JobsModel? jobsModel;
  RegionsModel? regionsModel;
  UniversitiesModel? universitiesModel;
  ProfileModel? profileModel;
  CategoryDetailsModel? categoryDetailsModel;
  PageDetailsModel? pageDetailsModel;
  DeleteModel? deleteModel;
  AddBookMarksModel? addBookMarksModel;
  RemoveBookMarksModel? removeBookMarksModel;
  BookMarksModel? bookMarksModel;
  AddMessageModel? addMessageModel;
  ThreadsModel? threadsModel;
  ThreadDetailsModel? threadDetailsModel;
  ForgetPasswordModel? forgetPasswordModel;
  NotificationModel? notificationModel;
  NotificationReadModel? notificationReadModel;
  SearchModel? searchModel;


  List<String> images = [];
  List<String> names = [];
  List<Widget> screens = [];


  void clearResources(){
    images.clear();
    names.clear();
    screens.clear();
  }

 Future<void> addResources()async{
   clearResources();
   if(pageDetailsModel!.data!.youtubePagesUrls!.length != 0){
     images.add('assets/images/videos2.jpg');
     names.add('Youtube');
     screens.add(YoutubeVideosScreen());
   }

    if(pageDetailsModel!.data!.audioPagesFiles!.length != 0){
     images.add( 'assets/images/audio.jpg');
     names.add('صوتيات');
     screens.add(AudioScreen());

   }

    if(pageDetailsModel!.data!.downloadablePagesFiles!.length != 0){
     images.add('assets/images/pdff.jpg');
     names.add('ملفات PDF');
     screens.add(PdfScreens());
   }

    if(pageDetailsModel!.data!.pagesPosts!.length != 0){
     images.add(  'assets/images/image.jpg');
     names.add('صور');
     screens.add(ImagesScreen());
   }

    if(pageDetailsModel!.data!.videoPagesFiles!.length != 0){
     images.add( 'assets/images/video3.jpg');
     names.add('فيديوهات');
     screens.add(VideosScreen());
   }

    if(pageDetailsModel!.data!.externalPagesUrls!.length != 0){
     images.add('assets/images/reference.jpg');
     names.add( 'روابط خارجية');
     screens.add(ReferenceScreen());
   }


 }



  Future<void> postPageDetails({required  id})async{
    pageDetailsModel = null;
    emit(GetPageDetailsLoading());
    DioHelper.postData(
      data: {
        'type' : 'page',
        'id' : id,
      },
      url: page_details,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) async {

      pageDetailsModel = PageDetailsModel.formJson(value.data);
      await addResources();
      emit(GetPageDetailsSuccess());

    });
  }











  void changeIndexScreen(int index){
    indexScreen = index;
    emit(ChangeIndexScreen());
  }

  void addMessage({required String message, required String image}){
    threadDetailsModel!.data!.allMessage.insert(
      0,

      AllMessage(
          message: message,
          image: image,
          owner: 1,
      ),
    );
    emit(AddMessageState());

  }

  void changeLanguageApp(){
    isArabic = !isArabic;
    language = isArabic? 'ar' : 'en';
    emit(ChangeLanguageApp());
  }


  Future<void> getHomeData() async {
    emit(GetHomeDataLoading());

    await DioHelper.getData(
      data: {},
      url: home,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(GetHomeDataSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetHomeDataError());
    });
  }

  void changeIndexSlider(int index){
    yourActiveIndexSlider = index;
    emit(ChangeIndexSlider());

  }

  void removeFromBookMarks(int index){
    bookMarksModel!.data!.pagesBookmarks!.removeAt(index);
    emit(RemoveFromBookMarks());
  }

  Future<void> postUserData({String? token})async{
    if( await CashHelper.getData(key: 'token') != ''){
      userModel = null;
      emit(GetUserDataLoading());
      await  Future.wait([getRegionData(),postGetUniversities(),getJobData()]);
      DioHelper.postData(
        data: {},
        url: verify_token,
        token:  CashHelper.getData(key: 'token')??'',
      ).then((value) async {


        userModel = UserModel.formJson(value.data);

        if(userModel!.hasError == false){
          nameController.text = userModel!.data!.student!.studentName!;
          phoneController.text = userModel!.data!.student!.studentPhone!;
          birthdateController.text = userModel!.data!.student!.studentBirthdate!;
          emailController.text = userModel!.data!.student!.studentEmail!;
          regionController.text =  getRegionName(userModel!.data!.student!.rEGIONID!);
          universityController.text =  getUniversityName(userModel!.data!.student!.studentUniversityID!);
          jobController.text = getJobName(userModel!.data!.student!.studentJobID!);

        }

        emit(GetUserDataSuccess(
          hasError: userModel!.hasError,
          errors: userModel!.errors,
          messages: userModel!.messages,
          token: userModel!.hasError? null : userModel!.data!.student!.studentAccesstoken,
        ));
      }).catchError((error){
        print(error.toString());
        emit(GetUserDataError());
      });

    }

  }

  Future<void> postUpdateUserData()async{
    if( await CashHelper.getData(key: 'token') != ''){
      emit(GetUserDataLoading());
      DioHelper.postData(
        data: {},
        url: verify_token,
        token:  CashHelper.getData(key: 'token')??'',
      ).then((value) async {


        userModel = UserModel.formJson(value.data);

        if(userModel!.hasError == false){
          nameController.text = userModel!.data!.student!.studentName!;
          phoneController.text = userModel!.data!.student!.studentPhone!;
          birthdateController.text = userModel!.data!.student!.studentBirthdate!;
          emailController.text = userModel!.data!.student!.studentEmail!;
          regionController.text =  getRegionName(userModel!.data!.student!.rEGIONID!);
          universityController.text =  getUniversityName(userModel!.data!.student!.studentUniversityID!);
          jobController.text = getJobName(userModel!.data!.student!.studentJobID!);

        }

        emit(GetUserDataSuccess(
          hasError: userModel!.hasError,
          errors: userModel!.errors,
          messages: userModel!.messages,
          token: userModel!.hasError? null : userModel!.data!.student!.studentAccesstoken,
        ));
      }).catchError((error){
        print(error.toString());
        emit(GetUserDataError());
      });

    }

  }



  Future<void> getCategory()async{
    emit(GetCategoryLoading());
    DioHelper.getData(
        data: {},
        url: category,
    ).then((value){
      categoryModel = CategoryModel.formJson(value.data);
      emit(GetCategorySuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoryError());
    });
  }

  Future<void> getJobData()async{
    emit(GetJobDataLoading());
    DioHelper.getData(
        data: {},
        url: jobs_request,
    ).then((value){

      jobsModel = JobsModel.formJson(value.data);
      emit(GetJobDataSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetJobDataError());
    });
  }

  String getJobName(String id) {
    String name =  '';
    jobsModel!.data!.studentJobs.forEach((element) {
      if (element.sTudentJOBID == id) {
        name =  element.studentjobName!;
      }
    });
    return name;
  }
  String getJobID(String name) {
    String id =  '';
    jobsModel!.data!.studentJobs.forEach((element) {
      if (element.studentjobName == name) {
        id =  element.sTudentJOBID!;
      }
    });
    return id;
  }


  Future<void> getRegionData() async {
    emit(GetRegionsLoading());
    DioHelper.getData(
      data: {},
      url: regions_request,
    ).then((value) {
      regionsModel = RegionsModel.formJson(value.data);

      emit(GetRegionsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetRegionsError());
    });
  }

  String getRegionName(String id) {
    String name =  '';
    regionsModel!.data!.regions.forEach((element) {
      if (element.rEGIONID == id) {
        name =  element.regionName;
      }
    });
    return name;
  }

  String getRegionID(String name) {
    String id =  '';
    regionsModel!.data!.regions.forEach((element) {
      if (element.regionName == name) {
        id =  element.rEGIONID;
      }
    });
    return id;
  }

  Future<void> postGetUniversities( ) async {
    universitiesModel = null;
    emit(GetUniversityLoading());

    await DioHelper.postData(
      data: {

      },
      url: universities,
    ).then((value) {
      universitiesModel = UniversitiesModel.formJson(value.data);
      emit(GetUniversitySuccess());
    }).catchError((error) {
      print(error);
      emit(GetUniversityError());
    });
  }

  String getUniversityName(String id) {
    String name = '';
    universitiesModel!.data!.universities.forEach((element) {
      if (element.universityID == id) {
        name = element.universityName!;
      }
    });
    return name;
  }
  String getUniversityID(String name) {
    String id = '';
    universitiesModel!.data!.universities.forEach((element) {
      if (element.universityName == name) {
        id = element.universityID!;
      }
    });
    return id;
  }

  Future pickImage(ImageSource source) async {
    try {
      final imagee = await ImagePicker().pickImage(source: source);
      if (imagee == null) return;
      File? img = File(imagee.path);
      img = await _cropImage(imageFile: img);

      image = img;
      emit(ImagePickerSuccess());
    } on PlatformException catch (error) {
      print(error);
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {

    try{
      CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
      if (croppedImage == null) return null;
      return File(croppedImage.path);
    }
    catch (error){
      print(error.toString());

    }
  }

  Future<void> postChangeProfile({
    required String studentRegionID,
    required String studentJOBID,
    required String universityId,
    required String student_name,
    required String student_birthdate,
    required String student_email,
    FormData? student_pic_file,
  }) async {

    FormData formData = FormData.fromMap({
      'REGIONID' :  await getRegionID(studentRegionID),
      'STUDENTJOBID': await getJobID(studentJOBID),
      'UNIVERSITYID':  await getUniversityID(universityId),
      'student_name': student_name,
      'student_birthdate': student_birthdate,
      'student_email': student_email,
      "student_pic_file": image == null
          ? ''
          : await MultipartFile.fromFile(
        image!.path,
        filename: image!.path.split('/').last,
        contentType: MediaType.parse('multipart/form-data'),
      ),
    });
    emit(ChangeProfileLoading());
    await DioHelper.postDataImage(
      data: formData,
      url: tech_profile,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) async {
      profileModel = ProfileModel.formJson(value.data);
      var token =  await CashHelper.getData(key: 'token');
      postUserData(token: token);
      emit(ChangeProfileSuccess(
          hasError:  profileModel!.hasError,
          messages:  profileModel!.messages,
          errors:  profileModel!.errors,
      ));
    }).catchError((error) {
      print(error);
      emit(ChangeProfileError());
    });
  }


  Future<void> postCategoryDetails({required  id})async{
    categoryDetailsModel = null;
    emit(GetCategoryDetailsLoading());
    DioHelper.postData(
        data: {
          'type' : 'cat',
           'id' : id,
        },
        token: await CashHelper.getData(key: 'token'),
        url: page_details
    ).then((value) {

      categoryDetailsModel = CategoryDetailsModel.formJson(value.data);
      emit(GetCategoryDetailsSuccess());

    }).catchError((error){
      print(error.toString());
      emit(GetCategoryDetailsError());
    });
  }


  Future<void> postDeleteAccount() async {
    emit(DeleteAccountLoading());

    await DioHelper.postData(
      data: {},
      url: delete_request,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) {

      deleteModel = DeleteModel.fromJson(value.data);
      emit(DeleteAccountSuccess());
    }).catchError((error){

    });
  }


  Future<void> postAddBookMarks({
    required id,
}) async {
    emit(AddBookMarksLoading());

    await DioHelper.postData(
      data: {
        'type' : 'add',
        'id' : id,
      },
      url: BOOKMARKS,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) {
      addBookMarksModel = AddBookMarksModel.fromJson(value.data);
      emit(AddBookMarksSuccess());
    }).catchError((error){
      print(error.toString());
      emit(AddBookMarksError());

    });
  }


  Future<void> postRemoveBookMarks({
    required id,
  }) async {
    emit(RemoveBookMarksLoading());

    await DioHelper.postData(
      data: {
        'type' : 'remove',
        'id' : id,
      },
      url: BOOKMARKS,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) {
      removeBookMarksModel = RemoveBookMarksModel.fromJson(value.data);
      emit(RemoveBookMarksSuccess());
    }).catchError((error){
      print(error.toString());
      emit(RemoveBookMarksError());

    });
  }


  Future<void> postBookMarks() async {
    emit(GetBookMarksLoading());

    await DioHelper.postData(
      data: {},
      url: BOOKMARKS,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) {
      print(value.data);
      bookMarksModel = BookMarksModel.fromJson(value.data);
      emit(GetBookMarksSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetBookMarksError());

    });
  }



  Future<void> postAddMessage({
    required String pageId,
    required String message,
    required String threadId,

}) async {
    emit(AddMessageLoading());

    await DioHelper.postData(
      data: {
        'PAGEID' : pageId,
        'type' : 'add',
        'id' : threadId,
        'message_text' : message
      },
      url: ADD_MESSAGE,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) {
      print(value.data);
      addMessageModel = AddMessageModel.fromJson(value.data);
      emit(AddMessageSuccess());
    }).catchError((error){
      print(error.toString());
      emit(AddMessageError());
    });
  }



  Future<void> postThreads()async{

    emit(GetThreadsLoading());
    DioHelper.postData(
        data: {},
        url: THREADS,
        token: await CashHelper.getData(key: 'token'),
    ).then((value){

      threadsModel = ThreadsModel.formJson(value.data);
      emit(GetThreadsSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetThreadsError());
    });

  }


  Future<void> postThreadsDetails({required String id,bool? load})async{
    if(load == null){
      threadDetailsModel = null;
    }

    emit(GetThreadsDetailsLoading());

    DioHelper.postData(
      data: {
        'type' : 'thread',
        'id' : id,
      },
      url: THREADS,
      token: await CashHelper.getData(key: 'token'),
    ).then((value){
      threadDetailsModel = ThreadDetailsModel.formJson(value.data);
      emit(GetThreadsDetailsSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetThreadsDetailsError());
    });

  }


  Future<void> postForgetPassword({required String email})async{

    emit(ForgetPasswordLoading());

    DioHelper.postData(
      data: {
        'student_email' : email,
      },
      url: forget_password,
      token: await CashHelper.getData(key: 'token')??'',
    ).then((value){
      print(value.data);
      forgetPasswordModel = ForgetPasswordModel.formJson(value.data);
      emit(ForgetPasswordSuccess(
        hasError: forgetPasswordModel!.hasError,
        errors: forgetPasswordModel!.errors,
        messages:  forgetPasswordModel!.messages,
      ));
    }).catchError((error){
      print(error.toString());
      emit(ForgetPasswordError());
    });

  }


  void logOut(){
    CashHelper.removeData(key: 'token');
    CashHelper.removeData(key: 'login');
   userModel = null;
    emit(LogOutState());
  }


  Future<void> postRestPassword({required String id,required String code,required password})async{
    emit(ResetPasswordLoading());

    await  DioHelper.postData(
      data: {

        'student_uniqueid': id,
        'student_reset_vcode': code,
        'student_password': password,
      },

      url: reset_password,

    ).then((value){
      userModel = UserModel.formJson(value.data);
      emit(ResetPasswordSuccess(
        hasError: userModel!.hasError,
        errors: userModel!.errors,
        messages: userModel!.messages,
        token: userModel!.hasError? '': userModel!.data!.student!.studentAccesstoken,
      ));
    }
    );

  }

  Future<void> getNotificationRead({required String id,required index}) async {
    notificationModel!.data!.studentsNotifications![index].studnotificationRead = "1";
    emit(NotificationReadLoading());

    await DioHelper.postData(
      data: {
        'id': id,
      },
      url: notification_request,
      token: CashHelper.getData(key: 'token')??'',
    ).then((value) {
      print(value.data);
      notificationReadModel = NotificationReadModel.formJson(value.data);
      emit(NotificationReadSuccess());
    }).catchError((error) {
      print(error);
      emit(NotificationReadError());
    });
  }

  Future<void> getNotification({required int page}) async {
    emit(NotificationLoading());

    await DioHelper.postData(
      data: {
        'page': page,
      },
      url: notification_request,
      token: CashHelper.getData(key: 'token'),
    ).then((value) {
      notificationModel = NotificationModel.formJson(value.data);
      emit(NotificationSuccess());
    });
  }


  Future<void> postSearch({required String  value})async{

    emit(SearchLoading());
    DioHelper.postData(
      data: {
        'search_query' : value,

      },
      url: page_details,
      token: await CashHelper.getData(key: 'token'),
    ).then((value) {
       print(value.data);
      searchModel = SearchModel.formJson(value.data);
      emit(SearchSuccess());

    }).catchError((error){
      print(error.toString());
    });
  }









}
