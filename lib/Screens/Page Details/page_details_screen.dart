import 'package:awesome_icons/awesome_icons.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Screens/Audios/page_details_audio.dart';
import 'package:education_application/Screens/Images/page_details_Images.dart';
import 'package:education_application/Screens/Pdf/page_details_pdf.dart';
import 'package:education_application/Screens/Play%20Audio/play_audio_screen.dart';
import 'package:education_application/Screens/Reference%20Screen/reference_screen.dart';
import 'package:education_application/Screens/Videos/video_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Network/Local/CashHelper.dart';
import '../BookMarks/bookmarks_screen.dart';
import '../Pdf/view_pdf.dart';
import '../Youtube Videos/page_details_videos.dart';

class PageDetailsScreen extends StatelessWidget {
  late String title;

  PageDetailsScreen({required this.title});

  CarouselController _carouselController = CarouselController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var messageController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener

        if (state is AddMessageSuccess) {
          var snackBar = buildSnackBar2(
              num: 1, title: 'عمليه ناجحه', message: 'تم اضافه الرسالة بنجاح');
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(

            actions: [
              GestureDetector(
                onTap: () {
                  buildBottomSheet(height, width, cubit);
                },
                child:SvgPicture.asset(
                  'assets/icons/chat.svg',
                  width: width*0.09,
                  color: Colors.white,
                  //semanticsLabel: 'A red up arrow'
                ),
              ),
            SizedBox(width: width*0.02,),

            cubit.pageDetailsModel == null? SizedBox() :
            GestureDetector(
                onTap: (){

                  if(CashHelper.getData(key: 'login') != null){
                    if( cubit.pageDetailsModel!.data!.page!.pageBookMarked == 1){
                      cubit.pageDetailsModel!.data!.page!.pageBookMarked= 0;
                      cubit.postRemoveBookMarks(
                        id: cubit.pageDetailsModel!.data!.page!.pAGEID,
                      );

                      if(cubit.bookMarksModel != null){
                        cubit.bookMarksModel!.data!.pagesBookmarks!.removeWhere(
                                (element) => element.pAGEID ==cubit.pageDetailsModel!.data!.page!.pAGEID
                        );
                      }

                    }
                    else
                    {
                      cubit.pageDetailsModel!.data!.page!.pageBookMarked = 1;
                      cubit.postAddBookMarks(
                        id: cubit.pageDetailsModel!.data!.page!.pAGEID,
                      );
                    }
                  }
                  else
                    {
                      navigateTo(context, BookMarksScreen());
                    }

                },
                child: SvgPicture.asset(
                  'assets/icons/fav.svg',
                  width: width*0.09,
                  color: cubit.pageDetailsModel!.data!.page!.pageBookMarked == 1?
                  Colors.red:
                  Colors.white,
                  //semanticsLabel: 'A red up arrow'
                ),
              ),
              SizedBox(width: width*0.02,),
            ],
          ),
          body: cubit.pageDetailsModel == null
              ? buildLoadingWidget()
              : SingleChildScrollView(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Center(
                        child: BuildText(
                            text:  cubit.pageDetailsModel!.data!.page!.pageName!,
                            bold: true,
                            size: 20,

                        ),
                      ),
                      //  BuildSlider(width, height, _carouselController, cubit),
                      SizedBox(
                        height: height * 0.02,
                      ),

                      //Divider(),
                      buildHtml(width, cubit),

                      Center(
                        child: BuildText(
                          text: 'المادة العلمية',
                          bold: true,
                          size: 20,

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: height * 0.3,
                              crossAxisCount: 2,
                              crossAxisSpacing: width*0.03,
                              mainAxisSpacing: 2
                          ),
                          itemCount: cubit.names.length,
                          itemBuilder: (context, index) {
                            return  GestureDetector(
                              onTap: (){
                                navigateTo(context, cubit.screens[index]);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: width,
                                    height: height * 0.2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                        child: Image.asset(cubit.images[index],
                                          fit: BoxFit.fill,
                                        ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height*0.02,
                                  ),
                                  Center(
                                    child: BuildText(
                                      text: cubit.names[index],
                                      bold: true,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildText(
                           text: 'هل لديك استفسار ؟',
                            size: 13,
                          ),
                          TextButton(
                            onPressed: () {
                             buildBottomSheet(height, width, cubit);
                            },
                            child: BuildText(
                              text: 'تواصل معنا',
                              bold: true,
                              size: 13,
                              ),
                            ),
                        ],
                      ),

                      SizedBox(height: height*0.02,),


                    ],
                  ),
                ),
        );
      },
    );
  }

  void buildBottomSheet(double height, double width, AppCubit cubit) {
      messageController.clear();
    scaffoldKey.currentState!.showBottomSheet(
      backgroundColor: Colors.white,
      (context) => SizedBox(
        height: height * 0.55,
        width: width,
        child: Container(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  buildTextFormFieldNote(
                      hint: 'أكتب الرسالة...',
                      controller: messageController,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الرساله';
                        }
                      },
                      description: true),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  buildButton(
                    width: width * 0.5,
                    height: height * 0.05,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        cubit.postAddMessage(
                          threadId: '0',
                          pageId: cubit.pageDetailsModel!.data!
                              .page!.pAGEID!,
                          message: messageController.text,
                        );
                        Navigator.pop(context);
                      }
                    },
                    text: 'إرسال',
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildListViewItem({
    required double height,
    required AppCubit cubit,
    required double width,
  }) {
    return SizedBox(
      height: height * 0.16,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: cubit.pageDetailsModel!.data!.audioPagesFiles!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateTo(
                context,
                PlayAudioScreen(
                  url: cubit.pageDetailsModel!.data!.audioPagesFiles![index]
                      .pagesfileFilename!,
                  name: cubit.pageDetailsModel!.data!.audioPagesFiles![index]
                      .pagesfileTitle!
                      .split('.')[0],
                ),
              );
            },
            child: buildItem(width, height, cubit, index),
          );
        },
      ),
    );
  }

  Padding buildItem(double width, double height, AppCubit cubit, int index) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: height * 0.1,
                width: width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  FontAwesomeIcons.music,
                  size: 50,
                  color: MyColor.primaryColor,
                )
                // Image.asset('assets/images/record.jpg'),
                ),
            SizedBox(
              height: height * 0.01,
            ),
            BuildText(
              text: cubit.pageDetailsModel!.data!.audioPagesFiles![index]
                  .pagesfileTitle!
                  .split('.')[0],
              size: 13,
              bold: true,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildCategoryText({required text}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: BuildText(
        text: text,
        size: 20,
        bold: true,
      ),
    );
  }

  Padding buildHtml(double width, AppCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Html(
        data: cubit.pageDetailsModel!.data!.page!.pageDescription,
        style: {
          'p': Style(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            //  fontSize: FontSize(15.0),
          ),
        },
      ),
    );
  }

  Container BuildSlider(double width, double height,
      CarouselController _carouselController, AppCubit cubit) {
    return Container(
      width: width,
      height: height * 0.2,
      child: CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: cubit.pageDetailsModel!.data!.pagesPosts!.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: buildImage(
                image: cubit.pageDetailsModel!.data!.pagesPosts![index]
                    .pagespostFilename,
                radius: 10),
          );
        },
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            // cubit.changeIndexSlider(index);
          },
          aspectRatio: 16 / 9,
          viewportFraction: 0.80,
          initialPage: 0,
          enableInfiniteScroll: true,
          //reverse: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
        ),
      ),
    );
  }
}
