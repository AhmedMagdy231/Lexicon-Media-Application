import 'dart:async';

import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Screens/Thread%20Details/thread_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../Network/Local/CashHelper.dart';

class ThreadsScreen extends StatefulWidget {
  final context;
  const ThreadsScreen({Key? key,required this.context}) : super(key: key);

  @override
  State<ThreadsScreen> createState() => _ThreadsScreenState();
}

class _ThreadsScreenState extends State<ThreadsScreen> {
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

    const duration = const Duration(seconds: 10);
    _timer =  Timer.periodic(duration, (Timer timer) {
      print('start');
      AppCubit.get(widget.context).postThreads();
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
            elevation: 0,

            forceMaterialTransparency: true,
            iconTheme: IconThemeData(
                color: Colors.grey
            ),
          ),

          body: CashHelper.getData(key: 'login') == null?
          buildLoginFirst(width, height, context) :
              cubit.threadsModel == null ?
           buildLoadingWidget():
            cubit.threadsModel!.data == null ||  cubit.threadsModel!.data!.threads!.length == 0?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/chat.svg',
                      width: width*0.35,
                      color: MyColor.primaryColor,
                      //semanticsLabel: 'A red up arrow'
                    ),
                    SizedBox(height: height*0.02,),
                    BuildText(
                        text: 'لا يوجد رسايل حتي الان',
                        color: Colors.black,
                      bold: true,

                    ),
                  ],
                ),
              ):
          Column(
            children: [
              Container(
                color:  cubit.threadsModel!.data!.threads![0].threadstudUnread! != "0"?
                MyColor.primaryColor:
                Colors.white,
                child: Container(
                  height: height*0.07,
                  width: width,
                  decoration:   BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width*0.09),
                    child: BuildText(
                      text: 'الدردشة',
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child:  ListView.builder(
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          cubit.threadsModel!.data!.threads![index].threadstudUnread = "0";
                          cubit.postThreadsDetails(
                            id:  cubit.threadsModel!.data!.threads![index].tHREADID!,
                          );

                          navigateTo(context, ThreadDetailsScreen(
                            title: cubit.threadsModel!.data!.threads![index].threadTopic!,
                            id: cubit.threadsModel!.data!.threads![index].tHREADID!,
                            context: context,
                          ));
                        },
                        child: Container(
                          height: height*0.122,
                          color: index == cubit.threadsModel!.data!.threads!.length-1? Colors.white:
                          cubit.threadsModel!.data!.threads![index+1].threadstudUnread! =="0"?
                          MyColor.white:
                          MyColor.primaryColor,
                          child: Container(
                            height: height*0.1,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(80),
                                )
                            ),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 0.3),
                              decoration: BoxDecoration(
                                  color:  cubit.threadsModel!.data!.threads![index].threadstudUnread! == "0"?
                                  MyColor.white: MyColor.primaryColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(80),
                                  )
                              ),

                              child: Padding(
                                padding:  EdgeInsets.only(right: width*0.12,left: width*0.02),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 27,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          cubit.threadsModel!.data!.threads![index].starterPic!,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width*0.04,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BuildText(
                                          text: cubit.threadsModel!.data!.threads![index].starterName!,
                                          bold: true,
                                          size: 16,
                                          color: cubit.threadsModel!.data!.threads![index].threadstudUnread! == "0"?
                                          Colors.black:
                                          Colors.white,
                                        ),
                                        BuildText(
                                          text: cubit.threadsModel!.data!.threads![index].threadTopic!,
                                          color: cubit.threadsModel!.data!.threads![index].threadstudUnread! == "0"?
                                          Colors.black:
                                          Colors.white,

                                        ),
                                        Row(
                                          children: [
                                            BuildText(
                                              text: cubit.threadsModel!.data!.threads![index].threadstudLastactiveDate!,
                                              size: 13,
                                              color: cubit.threadsModel!.data!.threads![index].threadstudUnread! == "0"?
                                              Colors.black26: Colors.white54,
                                              bold: true,
                                            ),
                                            SizedBox(
                                              width: width*0.02,
                                            ),
                                            BuildText(
                                              text: formatTime(int.parse(cubit.threadsModel!.data!.threads![index].threadstudLastactiveTime!)),
                                              size: 13,
                                              color: cubit.threadsModel!.data!.threads![index].threadstudUnread! == "0"?
                                              Colors.black26: Colors.white54,
                                              bold: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),

                                    cubit.threadsModel!.data!.threads![index].threadstudUnread! == '0'?
                                    SvgPicture.asset(
                                      'assets/icons/double_check.svg',
                                      width: 25,
                                      color:   cubit.threadsModel!.data!.threads![index].threadstudUnread == 1? Colors.grey :  Colors.blue,
                                      //semanticsLabel: 'A red up arrow'
                                    ):
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(5),
                                      child: BuildText(
                                        text: cubit.threadsModel!.data!.threads![index].threadstudUnread!,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )

                              ),

                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.threadsModel!.data!.threads!.length,
                  ),
              )
            ],
          ),

        );
      },
    );
  }

  Shimmer buildBuildShimmerLoading(double width, double height) {
    return buildShimmer(
                child: SizedBox(
                  width: width,
                  height: height*0.12,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: width*0.02),
                    child: Card(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
  }
}



/*

 */