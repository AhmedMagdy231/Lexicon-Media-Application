import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Screens/Youtube%20Videos/show_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/components.dart';
import '../../Constant/Colors/colors.dart';

import '../Play Audio/play_audio_screen.dart';

class YoutubeVideosScreen extends StatelessWidget {
  const YoutubeVideosScreen({Key? key}) : super(key: key);

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

          body: cubit.pageDetailsModel!.data!.youtubePagesUrls!.length ==0?
              buildNoItem(
                  width,
                  height,
                  name: 'assets/icons/youtube.svg',
                  text: 'لا يوجد فيديوهات بعد',
                  color: false,
              ): Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: width,
                        height: height*0.2,
                        decoration:  BoxDecoration(
                            color: MyColor.primaryColor,
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/search.png',
                              ),
                              fit: BoxFit.cover,
                            )
                        ),
                        child: Center(
                          child: BuildText(
                            text: 'Youtube',
                            size: 25,
                            color: Colors.white,
                            bold: true,
                          ),
                        ),
                      ),
                      Positioned(
                        top: height*0.04,
                        right: width*0.02,
                        child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: height * 0.26,
                      crossAxisCount: 2,
                      crossAxisSpacing: width*0.03,
                      mainAxisSpacing: 2
            ),
            itemCount: cubit.pageDetailsModel!.data!.youtubePagesUrls!.length,
            itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateTo(
                          context,
                          ShowYoutubeVideoScreen(
                              url: cubit
                                  .pageDetailsModel!
                                  .data!
                                  .youtubePagesUrls![
                              index]
                                  .pagesurlValue,
                          ),
                        );
                      },
                      child: buildItem(width, height, cubit, index),
                    );
            },

          ),
                  ),
                ],
              ),
        );
      },
    );
  }
  Padding buildItem(double width, double height, AppCubit cubit, int index) {
    return Padding(
      padding: EdgeInsets.all(width * 0.02),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: height * 0.15,
              width: width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SvgPicture.asset(
                'assets/icons/youtube.svg',
                width: width*0.35,
              ),

            ),
            SizedBox(
              height: height * 0.02,
            ),
            BuildText(
              text: cubit.pageDetailsModel!.data!.youtubePagesUrls![index].pagesurlTitle!,
              size: 13,
              bold: true,
              center: true,
            ),
          ],
        ),
      ),
    );
  }
}
