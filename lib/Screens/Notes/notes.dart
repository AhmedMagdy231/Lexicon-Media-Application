import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Cubits/Local%20Database%20Cubit/database_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatelessWidget {
   NotesScreen({Key? key}) : super(key: key);
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<DatabaseCubit, DatabaseState>(
      listener: (context, state) {
        // TODO: implement listener

        if (state is DeleteNotesSuccess) {
          var snackBar = buildSnackBar2(
              num: 1,
              milSecond: 1000,
              title: 'عمليه ناجحه',
              message: 'تم مسح الملاحظة');
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is InsertNotesSuccess) {
          var snackBar = buildSnackBar2(
              num: 1,
              milSecond: 1000,
              title: 'عمليه ناجحه',
              message: 'تم اضافة الملاحظة');
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var height = MediaQuery
            .of(context)
            .size
            .height;
        var width = MediaQuery
            .of(context)
            .size
            .width;
        var cubit = DatabaseCubit.get(context);


        return Scaffold(
          key: scaffoldKey,
        //  backgroundColor: Color(0xffEDEDF5),
          body: state is GetNotesLoading
              ? buildLoadingWidget()
              : Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                TextField(
                  onChanged: cubit.searchText,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    hintText: 'ابحث عن ملاحظتك...',
                    hintStyle: GoogleFonts.notoNaskhArabic(
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                BuildText(
                  text: 'الملاحظات',
                  size: 25,
                  bold: true,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Expanded(
                  child: cubit.filterNotes.length == 0
                      ? buildWidgetNoNotes(height)
                      : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (_) =>
                                  AlertDialog(
                                    title: BuildText(
                                      text: cubit.filterNotes[index].title,
                                      bold: true,
                                    ),
                                    content: SingleChildScrollView(
                                      child: BuildText(
                                        text: cubit.filterNotes[index].description,
                                        size: 15,
                                      ),
                                    ),

                                  ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            child: ListTile(
                              title: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                text: TextSpan(
                                  text:
                                  '${cubit.filterNotes[index].title}\n',
                                  style:
                                  GoogleFonts.notoNaskhArabic(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    decoration: cubit
                                        .filterNotes[index]
                                        .finish
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                      '${cubit.filterNotes[index].description}',
                                      style: GoogleFonts
                                          .notoNaskhArabic(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.normal,
                                        decoration:
                                        TextDecoration.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding:  EdgeInsets.only(top: 5),
                                child: BuildText(
                                  text:
                                  '${cubit.filterNotes[index].date}   ${cubit
                                      .filterNotes[index].time}',
                                  color: Colors.grey,
                                  size: 12,
                                  bold: true,
                                ),
                              ),
                              leading: Transform.scale(
                                scale: 1.7,
                                child: Checkbox(
                                  value: cubit
                                      .filterNotes[index].finish,
                                  onChanged: (value) {
                                    cubit.changeFinishNote(
                                        index,
                                        cubit
                                            .filterNotes[index].id);
                                  },
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) =>
                                        AlertDialog(
                                          title: BuildText(
                                            text:
                                            ' مسح ملاحظه ${cubit
                                                .filterNotes[index].title}',
                                            bold: true,
                                          ),
                                          content: BuildText(
                                            text:
                                            'هل أنت متأكد من حذف هذه الملاحظة ؟',
                                            size: 15,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: BuildText(
                                                text: 'لا',
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                cubit.deleteNote(
                                                    index: index,
                                                    id: cubit
                                                        .filterNotes[
                                                    index]
                                                        .id);
                                                Navigator.pop(context);
                                              },
                                              child: BuildText(
                                                text: 'نعم',
                                              ),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.filterNotes.length,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: MyColor.primaryColor,
            onPressed: () {
              titleController.clear();
              descriptionController.clear();
              scaffoldKey.currentState!.showBottomSheet(
                    (context) =>
                    SizedBox(
                      height: height * 0.7,
                      width: width,
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.05,
                              horizontal: width * 0.05),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  buildTextFormFieldNote(
                                    hint: 'عنوان الملاحظة',
                                    controller: titleController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك ادخل عنوان الملاحظة';
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  buildTextFormFieldNote(
                                    hint: 'تفاصيل الملاحظة',
                                    controller: descriptionController,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك ادخل تفاصيل الملاحظة';
                                      }
                                    },
                                    description: true,
                                  ),

                                  SizedBox(
                                    height: height * 0.05,
                                  ),

                                  buildButton(
                                    width: width * 0.5,
                                    height: height * 0.05,
                                    function: () {

                                      if (formKey.currentState!.validate()) {
                                        cubit.insertNewNote(
                                            title: titleController.text,
                                            description: descriptionController.text,
                                            date: DateFormat('d/MM/yyyy').format(DateTime.now()).toString(),
                                            time: DateFormat.jm().format(DateTime.now()).toString()
                                        );
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: 'حفظ',
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },
            child: const Icon(
              FontAwesomeIcons.plus,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }



  Center buildWidgetNoNotes(double height) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.tasks,
            color: MyColor.primaryColor,
            size: 50,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          BuildText(text: 'لا يوجد ملاحظات'),
        ],
      ),
    );
  }
}
