import 'package:animate_do/animate_do.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Screens/Category%20Details/category_details.dart';
import 'package:education_application/Screens/Page%20Details/page_details_screen.dart';
import 'package:education_application/Screens/Thread%20Details/thread_details_screen.dart';
import 'package:education_application/Screens/Threads/threads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({Key? key}) : super(key: key);

  List<Color> myColors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.green,
  ];

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        forceMaterialTransparency: true,
        iconTheme: IconThemeData(
            color: Colors.grey
        ),
      ),

      body: cubit.notificationModel == null ?
        buildLoadingWidget():
        cubit.notificationModel!.data == null ?
        Container(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/notification.svg',
                width: 70,
                color: MyColor.primaryColor,
                //semanticsLabel: 'A red up arrow'
              ),
              SizedBox(height: height*0.02,),
              BuildText(
                text: 'لا يوجد لديك أي تنبيهات حتى الآن',
                size: 18,
                bold: true,
                color: Colors.grey,
              ),
            ],
          ),
        ):
      Column(
          children: [
            Container(
              color:  cubit.notificationModel!.data!.studentsNotifications![0].studnotificationRead! =="0"?
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
                    text: 'الاشعارات',
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(

                itemCount: int.parse(cubit.notificationModel!.data!.resultsTotal!),
                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap: (){

                cubit.getNotificationRead(
                    index: index,
                    id:  cubit.notificationModel!.data!
                        .studentsNotifications![index]
                        .sTUDNOTIFICATIONID!
                ).then((value){
                  cubit.postUpdateUserData();
                });

                if(cubit.notificationModel!.data!.studentsNotifications![index].studnotificationAction == 'profile'){
                  Navigator.pop(context);
                  cubit.changeIndexScreen(3);
                }
                else if(cubit.notificationModel!.data!.studentsNotifications![index].studnotificationAction == 'threads'){
                  if(cubit.notificationModel!.data!.studentsNotifications![index].studnotificationActionId == "0"){
                    navigateTo(context, ThreadsScreen(context: context));
                  }
                  else
                  {
                    cubit.postThreadsDetails(id: cubit.notificationModel!.data!.studentsNotifications![index].studnotificationActionId!);
                    navigateTo(context, ThreadDetailsScreen(
                      context: context,
                      id: cubit.notificationModel!.data!.studentsNotifications![index].studnotificationActionId!,
                      title: 'رسالة جديدة',
                    )
                    );
                  }
                }
                else if(cubit.notificationModel!.data!.studentsNotifications![index].studnotificationAction == 'pages_cats') {
                  cubit.postCategoryDetails(id: cubit.notificationModel!.data!.studentsNotifications![index].studnotificationActionId);
                  navigateTo(
                    context,
                    CategoryDetailsScreen(
                        categoryName: '',
                        context: context
                    ),
                  );
                }
                else if(cubit.notificationModel!.data!.studentsNotifications![index].studnotificationAction == 'pages') {
                  cubit.postPageDetails(id: cubit.notificationModel!.data!.studentsNotifications![index].studnotificationActionId);
                  navigateTo(context, PageDetailsScreen(title: ''));

                }
                      },
                      child: Container(
                        height: height*0.124,
                        color: index == cubit.notificationModel!.data!.studentsNotifications!.length-1? Colors.white:
                            cubit.notificationModel!.data!.studentsNotifications![index+1].studnotificationRead! =="0"? MyColor.primaryColor: Colors.white,
                        child: Container(
                          height: height*0.1,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(80),
                              )
                          ),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 0.3),
                            decoration: BoxDecoration(
                                color:  cubit.notificationModel!.data!.studentsNotifications![index].studnotificationRead! =="1"?
                                MyColor.white: MyColor.primaryColor,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(80),
                                )
                            ),

                            child: Padding(
                              padding:  EdgeInsets.only(right: 50),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(cubit.userModel == null? '' : cubit.userModel!.data!.student!.studentPic!),
                                    ),
                                    backgroundColor: Colors.white,
                                    radius: 27,
                                  ),
                                  SizedBox(width: width*0.05,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        BuildText(
                                          color: cubit.notificationModel!.data!.studentsNotifications![index].studnotificationRead! =="1"?
                                              Colors.black: Colors.white,
                                          text: cubit.notificationModel!.data!
                                              .studentsNotifications![index]
                                              .studnotificationMessage!,
                                          maxLines: 2,
                                          overflow: true,
                                        ),
                                        SizedBox(height: height * 0.005,),
                                        Row(
                                          children: [
                                            BuildText(
                                              text: cubit.notificationModel!.data!
                                                  .studentsNotifications![index]
                                                  .studnotificationDate!,
                                              color: cubit.notificationModel!.data!.studentsNotifications![index].studnotificationRead! =="1"?
                                              Colors.black26: Colors.white54,
                                            ),
                                            SizedBox(width: width * 0.02,),
                                            BuildText(
                                              text: formatTime(int.parse(cubit.notificationModel!.data!
                                                  .studentsNotifications![index]
                                                  .studnotificationTime!)),
                                              size: 15,
                                              color: cubit.notificationModel!.data!.studentsNotifications![index].studnotificationRead! =="1"?
                                              Colors.black26: Colors.white54,
                                            ),


                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: width*0.04,
                                      width: width*0.04,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
      ),
    );
  },
);
  }
}


