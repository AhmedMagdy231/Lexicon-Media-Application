part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}


class GetRegionsLoading extends AuthState{}
class GetRegionsSuccess extends AuthState{}
class GetRegionsError extends AuthState{}

class GetCityLoading extends AuthState{}
class GetCitySuccess extends AuthState{}
class GetCityError extends AuthState{}

class GetUniversityLoading extends AuthState{}
class GetUniversitySuccess extends AuthState{}
class GetUniversityError extends AuthState{}


class LoginLoading extends AuthState{}
class LoginSuccess extends AuthState{
  final bool hasError;
  final List messages;
  final List errors;
  final String? token;
 LoginSuccess({required this.hasError,required this.messages,required this.errors, required this.token});

}
class LoginError extends AuthState{}

class RegisterLoading extends AuthState{}
class RegisterSuccess extends AuthState{
  final bool hasError;
  final List messages;
  final List errors;
  RegisterSuccess({required this.hasError,required this.messages,required this.errors});

}
class RegisterError extends AuthState{}

class OTPLoading extends AuthState{}
class OTPSuccess extends AuthState{
  final bool hasError;
  final List messages;
  final List errors;
  final String? token;
  OTPSuccess({required this.hasError,required this.messages,required this.errors,required this.token});
}
class OTPError extends AuthState{}