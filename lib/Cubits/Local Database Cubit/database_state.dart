part of 'database_cubit.dart';

@immutable
abstract class DatabaseState {}

class DatabaseInitial extends DatabaseState {}

class SearchState extends DatabaseState {}
class ChangeFinishNote extends DatabaseState {}



class GetNotesLoading extends DatabaseState{}
class GetNotesSuccess extends DatabaseState{}
class GetNotesError extends DatabaseState{}

class  InsertNotesLoading extends DatabaseState{}
class  InsertNotesSuccess extends DatabaseState{}
class  InsertNotesError extends DatabaseState{}

class  UpdateNotesLoading extends DatabaseState{}
class  UpdateNotesSuccess extends DatabaseState{}
class  UpdateNotesError extends DatabaseState{}

class  DeleteNotesLoading extends DatabaseState{}
class  DeleteNotesSuccess extends DatabaseState{}
class  DeleteNotesError extends DatabaseState{}
