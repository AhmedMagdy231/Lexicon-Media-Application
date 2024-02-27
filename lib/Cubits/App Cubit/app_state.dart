part of 'app_cubit.dart';



abstract class AppState {}

class AppInitial extends AppState {}

class ChangeIndexSlider extends AppState {}

class RemoveFromBookMarks extends AppState {}


class ChangeIndexScreen extends AppState {}
class ChangeLanguageApp extends AppState {}

class GetHomeDataLoading extends AppState{}
class GetHomeDataSuccess extends AppState{}
class GetHomeDataError extends AppState{}

class SearchLoading extends AppState{}
class SearchSuccess extends AppState{}
class SearchError extends AppState{}


class GetUserDataLoading extends AppState{}
class GetUserDataSuccess extends AppState{
  final bool hasError;
  final List messages;
  final List errors;
  final String? token;
  GetUserDataSuccess({required this.hasError,required this.messages,required this.errors, required this.token});
}
class GetUserDataError extends AppState{}


class GetCategoryLoading extends AppState{}
class GetCategorySuccess extends AppState{}
class GetCategoryError extends AppState{}


class GetJobDataLoading extends AppState{}
class GetJobDataSuccess extends AppState{}
class GetJobDataError extends AppState{}

class GetRegionsLoading extends AppState{}
class GetRegionsSuccess extends AppState{}
class GetRegionsError extends AppState{}

class GetUniversityLoading extends AppState{}
class GetUniversitySuccess extends AppState{}
class GetUniversityError extends AppState{}

class ChangeProfileLoading extends AppState{}
class ChangeProfileSuccess extends AppState{
  final bool hasError;
  final List messages;
  final List errors;

  ChangeProfileSuccess({required this.hasError,required this.messages,required this.errors,});
}
class ChangeProfileError extends AppState{}


class ImagePickerSuccess extends AppState{}

class GetCategoryDetailsLoading extends AppState{}
class GetCategoryDetailsSuccess extends AppState{}
class GetCategoryDetailsError extends AppState{}

class GetPageDetailsLoading extends AppState{}
class GetPageDetailsSuccess extends AppState{}
class GetPageDetailsError extends AppState{}

class DeleteAccountLoading extends AppState{}
class DeleteAccountSuccess extends AppState{}
class DeleteAccountError extends AppState{}

class AddBookMarksLoading extends AppState{}
class AddBookMarksSuccess extends AppState{}
class AddBookMarksError extends AppState{}

class RemoveBookMarksLoading extends AppState{}
class RemoveBookMarksSuccess extends AppState{}
class RemoveBookMarksError extends AppState{}

class GetBookMarksLoading extends AppState{}
class GetBookMarksSuccess extends AppState{}
class GetBookMarksError extends AppState{}

class AddMessageLoading extends AppState{}
class AddMessageSuccess extends AppState{}
class AddMessageError extends AppState{}

class GetThreadsLoading extends AppState{}
class GetThreadsSuccess extends AppState{}
class GetThreadsError extends AppState{}


class GetThreadsDetailsLoading extends AppState{}
class GetThreadsDetailsSuccess extends AppState{}
class GetThreadsDetailsError extends AppState{}

class AddMessageState extends AppState{}


class ForgetPasswordLoading extends AppState{}
class ForgetPasswordSuccess extends AppState{
  final bool hasError;
  final List messages;
  final List errors;

  ForgetPasswordSuccess({required this.hasError,required this.messages,required this.errors,});
}
class ForgetPasswordError extends AppState{}



class ResetPasswordLoading extends AppState{}
class ResetPasswordSuccess extends AppState{
  final bool hasError;
  final List messages;
  final List errors;
  final token;

  ResetPasswordSuccess({required this.hasError,required this.messages,required this.errors, required this.token});
}
class ResetPasswordError extends AppState{}


class LogOutState extends AppState{}



class NotificationLoading extends AppState{}
class NotificationSuccess extends AppState{}
class NotificationError extends AppState{}

class NotificationReadLoading extends AppState{}
class NotificationReadSuccess extends AppState{}
class NotificationReadError extends AppState{}