import 'package:bloc/bloc.dart';
import 'package:education_application/Models/Cities/cities_model.dart';
import 'package:education_application/Models/Login/login_model.dart';
import 'package:education_application/Models/Register/Register_model.dart';
import 'package:education_application/Models/regions/regions_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/Universities/center_model.dart';
import '../../Network/Remote/dio_helper.dart';
import '../../Network/endPoind.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  RegionsModel? regionsModel;
  CitiesModel? citiesModel;
  UniversitiesModel? universitiesModel;
  LoginModel? loginModel;
  RegisterModel? registerModel;

  bool selectRegion = false;
  int regionID = -1;
  int universityId = -1;
  bool selectCity = false;

  static AuthCubit get(context) => BlocProvider.of(context);

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

  int getRegionId(String name) {
    int id = -1;
    regionsModel!.data!.regions.forEach((element) {
      if (element.regionName == name) {
        id = int.parse(element.rEGIONID);
      }
    });
    return id;
  }

  Future<void> getAllCities({required int id}) async {
    citiesModel = null;
    emit(GetCityLoading());

    await DioHelper.postData(
      data: {'id': id, 'lang': 'ar'},
      url: cities_request,
    ).then((value) {
      citiesModel = CitiesModel.formJson(value.data);
      emit(GetCitySuccess());
    });
  }

  int getCityId(String name) {
    int id = -1;
    citiesModel!.data!.cities!.forEach((element) {
      if (element.cityName == name) {
        id = int.parse(element.cITYID);
      }
    });
    return id;
  }

  Future<void> postGetUniversities() async {
    universitiesModel = null;
    emit(GetUniversityLoading());

    await DioHelper.postData(
      data: {},
      url: universities,
    ).then((value) {
      universitiesModel = UniversitiesModel.formJson(value.data);
      emit(GetUniversitySuccess());
    }).catchError((error) {
      print(error);
      emit(GetUniversityError());
    });
  }

  int getUniversityId(String name) {
    int id = -1;
    universitiesModel!.data!.universities.forEach((element) {
      if (element.universityName == name) {
        id = int.parse(element.universityID!);
      }
    });
    return id;
  }

  Future<void> postLogin(
      {required String email, required String password}) async {
    emit(LoginLoading());

    await DioHelper.postData(
      data: {
        'student_email': email,
        'student_password': password,
      },
      url: LOGIN_REQUEST,
    ).then((value) {
      print(value);
      loginModel = LoginModel.formJson(value.data);

      emit(LoginSuccess(
        hasError: loginModel!.hasError,
        errors: loginModel!.errors,
        messages: loginModel!.messages,
        token: loginModel!.hasError? null : loginModel!.data!.student!.studentAccesstoken,
      ));

      print(loginModel!.data!.student!.studentEmail);
    }).catchError((error) {
      print(error.toString());
    });
  }

  Future<void> postRegister({
    required email,
    required phone,
    required password,
    required universityId,
    required name,
  }) async {
    emit(RegisterLoading());
    DioHelper.postData(
      data: {
        'UNIVERSITYID': universityId,
        'REGIONID': this.regionID,
        'accept_tos': 1,
        'student_email': email,
        'student_phone': phone,
        'student_name': name,
        'student_password': password,
      },
      url: register_request,
    ).then((value) {
      print(value);
      registerModel = RegisterModel.formJson(value.data);
      emit(RegisterSuccess(hasError: registerModel!.hasError, messages: registerModel!.messages, errors:  registerModel!.errors));
    }).catchError((error) {
      emit(RegisterError());
      print(error.toString());
    });
  }

  Future<void> postLoginVerify(String id,String code)async{
    emit(OTPLoading());

    await  DioHelper.postData(
      data: {

        'student_uniqueid': id,
        'student_vcode': code,

      },
      url: login_request,
    ).then((value){
      print(value.data);
      loginModel = LoginModel.formJson(value.data);
      if(loginModel!.hasError){
        emit(OTPSuccess(hasError: loginModel!.hasError,messages: loginModel!.messages,errors: loginModel!.errors,token: null));
      }
      else
      {
        emit(OTPSuccess(hasError: loginModel!.hasError,messages: loginModel!.messages,errors: loginModel!.errors,token:loginModel!.data!.student!.studentAccesstoken!));
      }


    });

  }


}
