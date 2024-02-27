import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'show_imag.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

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
          body: cubit.pageDetailsModel!.data!.pagesPosts!.length ==0?
              buildNoItem(width, height,
                  name: 'assets/icons/image.svg',
                  text: 'لا يوجد صور بعد'
              )
              :  Column(
                children: [
                  buildContainerStack(height: height, width: width, context: context, text: 'الصور'),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: height * 0.26,
                          crossAxisCount: 2,
                      ),
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            navigateTo(
                                context,
                                ZoomImage(images: cubit.pageDetailsModel!.data!.pagesPosts!, index: index,));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            padding: EdgeInsets.all(1),
                            margin: EdgeInsets.all(2),
                            child: buildImage(
                                image: cubit.pageDetailsModel!.data!.pagesPosts![index].pagespostFilename!,
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.pageDetailsModel!.data!.pagesPosts!.length,
                    ),
                  ),
                ],
              ),
        );
      },
    );
  }
}
