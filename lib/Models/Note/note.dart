class Note {
  late String title;
  late String description;
  late String date;
  late String time;
  late bool finish;
  late int id;


  Note({required this.title,required this.id,required this.description,required this.date ,this.finish= false,required this.time});

  Note.fromJson(Map<String,dynamic> data){
    id = data['id'];
    title = data['title'];
    description = data['description'];
    date = data['date'];
    time = data['time'];
    finish = data['finish'] == 0? false : true;
  }


}