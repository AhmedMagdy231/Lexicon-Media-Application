

import 'dart:async';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';




class ThreadDetailsScreen extends StatefulWidget {
   late String title;
   late String id;
   final context;
   ThreadDetailsScreen({Key? key,required this.title,required this.id,required this.context}) : super(key: key);


  @override
  State<ThreadDetailsScreen> createState() => _ThreadDetailsScreenState();
}

class _ThreadDetailsScreenState extends State<ThreadDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  var messageController = TextEditingController();
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();


  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to clean up resources
    super.dispose();
  }

  void getData() {

    const duration = const Duration(seconds: 2);
   _timer =  Timer.periodic(duration, (Timer timer) {
     print('start');
      AppCubit.get(widget.context).postThreadsDetails(
        id:  widget.id,
        load: false,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: BuildText(
              text:  widget.title,
              bold: true,
            ),
          ),
          body: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroud_chat.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              children: [
                Expanded(
                    child: cubit.threadDetailsModel == null? buildLoadingWidget(): ListView.builder(
                      controller: _scrollController,
                        reverse: true,
                        itemBuilder: (context,index){
                          return  Directionality(
                           textDirection:  cubit.threadDetailsModel!.data!.allMessage[index].owner==1?
                           TextDirection.ltr:
                           TextDirection.rtl,
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: width*0.02,vertical: height*0.005),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      cubit.threadDetailsModel!.data!.allMessage[index].image,
                                    ),
                                  ),
                                  BubbleSpecialThree(
                                    isSender: cubit.threadDetailsModel!.data!.allMessage[index].owner==1,
                                    text: '${cubit.threadDetailsModel!.data!.allMessage[index].message}',
                                    color:  MyColor.primaryColor,
                                    tail: false,
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      itemCount: cubit.threadDetailsModel!.data!.allMessage.length,
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onSubmitted: (value){
                            print(value);
                          },
                          controller: messageController,
                          minLines: 1,
                          maxLines: 5,
                          style: GoogleFonts.notoNaskhArabic(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                             enabledBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(12),
                                 borderSide: BorderSide(color: Colors.transparent)
                             ),
                             focusedBorder: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(12),
                                 borderSide: BorderSide(color: Colors.transparent)
                             ),
                             fillColor: MyColor.primaryColor,
                             filled: true,
                             hintStyle: GoogleFonts.notoNaskhArabic(color: Colors.white70),
                             hintText: 'الرساله...'

                          ),
                        ),
                      ),
                      SizedBox(width: width*0.02,),
                      GestureDetector(
                        onTap: (){
                          cubit.postAddMessage(
                              pageId: '0',
                              message: messageController.text,
                              threadId: cubit.threadDetailsModel!.data!.thread!.tHREADID!,
                          );
                          setState(() {
                            print(cubit.userModel!.data!.student!.studentPic!);
                             cubit.addMessage(
                                 message: messageController.text,
                                 image: cubit.userModel!.data!.student!.studentPic!,
                             );
                            _scrollController.jumpTo(_scrollController.position.minScrollExtent);
                          });

                          messageController.clear();

                        },
                        child: CircleAvatar(
                          radius: width*0.06,
                          child: Icon(Icons.send_rounded,color: Colors.white,),
                          backgroundColor: MyColor.primaryColor,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),


          ),


        );
      },
    );
  }
}
