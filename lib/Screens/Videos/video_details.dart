import 'package:animate_do/animate_do.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Screens/Videos/show_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../Components/components.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({Key? key}) : super(key: key);

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

          body: cubit.pageDetailsModel!.data!.videoPagesFiles!.length == 0
              ? buildNoItem(
                  width,
                  height,
                  name: 'assets/icons/youtube.svg',
                  text: 'لا يوجد فيديوهات بعد',
                  color: false,
                )
              : Column(
                children: [
                  buildContainerStack(height: height, width: width, context: context, text: 'الفيديوهات'),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: height * 0.18,
                            crossAxisCount: 3,
                            crossAxisSpacing: width * 0.01,
                            mainAxisSpacing: 0
                        ),
                        itemCount:
                            cubit.pageDetailsModel!.data!.videoPagesFiles!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              navigateTo(
                                context,
                                ShowVideoScreen(
                                    url: cubit.pageDetailsModel!.data!
                                        .videoPagesFiles![index].pagesfileFilename),
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

  Widget buildItem(double width, double height, AppCubit cubit, int index) {
    return FadeInDown(
      from: height*0.3,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.02),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height * 0.1,
                width: width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/video4.jpg',fit: BoxFit.contain,)
              ),
              SizedBox(
                height: height * 0.02,
              ),
              BuildText(
                text: cubit.pageDetailsModel!.data!.videoPagesFiles![index]
                    .pagesfileTitle!.split('.')[0],
                size: 12,
                maxLines: 2,
                bold: true,
                center: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
