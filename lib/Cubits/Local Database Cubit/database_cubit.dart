import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../Models/Note/note.dart';
import '../../Network/Local/Database/database.dart';

part 'database_state.dart';

class DatabaseCubit extends Cubit<DatabaseState> {
  DatabaseCubit() : super(DatabaseInitial());

  static DatabaseCubit get(context)=>BlocProvider.of(context);
  List<Note> allnotes = [];
  List<Note> filterNotes = [];

  Future<void> getAllNotes() async{
    emit(GetNotesLoading());
    MyDatabase.getAllData().then((value){
      value.forEach((element) {
        Note n = Note.fromJson(element);
        allnotes.add(n);
      });
      filterNotes = allnotes;
      emit(GetNotesSuccess());
    }).catchError((error){
      print(error.toString());
      emit(GetNotesError());
    });

  }

  void searchText(String input){
    filterNotes = allnotes
        .where((element) =>
        element.title.toLowerCase().contains(input.toLowerCase()))
        .toList();

    emit(SearchState());

  }

  void changeFinishNote(int index,int id){

    allnotes[index].finish = !allnotes[index].finish;
    MyDatabase.updateFinish(finish: allnotes[index].finish , id: id);
    emit(ChangeFinishNote());

  }

  void deleteNote({required int index,required int id}){
    emit(DeleteNotesLoading());
    MyDatabase.deleteRow(id: id).then((value) async {
      if(value == 1){
        await allnotes.removeAt(index);
        filterNotes = allnotes;
        emit(DeleteNotesSuccess());

      }
    }).catchError((error){
      print(error.toString());
      emit(DeleteNotesError());
    });

  }

  Future<int> insertNewNote({
    required title,
    required description,
    required date,
    required time,
})async{
    int result = -1;
    emit(InsertNotesLoading());
    await MyDatabase.insertRow(
        title: title,
        description: description,
        date: date,
        time: time
    ).then((value){
      result = value;
      Note n = Note(
        title: title,
        description:  description,
        date:  date,
        time: time,
        id: value,
      );
      allnotes.add(n);
      filterNotes = allnotes;
      emit(InsertNotesSuccess());

    }).catchError((error){
      emit(InsertNotesError());
      print(error.toString());
    });

    return result;

  }






}
