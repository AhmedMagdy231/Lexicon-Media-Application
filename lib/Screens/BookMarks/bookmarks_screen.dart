import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/Text/text.dart';
import '../../Components/components.dart';
import '../../Constant/Colors/colors.dart';
import '../../Network/Local/CashHelper.dart';
import '../Page Details/page_details_screen.dart';

class BookMarksScreen extends StatelessWidget {
  const BookMarksScreen({Key? key}) : super(key: key);

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
              text:  'المفضلة',
              bold: true,
            ),
          ),
          body: CashHelper.getData(key: 'login') == null?
              buildLoginFirst(width, height, context)
              :  cubit.bookMarksModel == null? buildLoading(width, height) : cubit.bookMarksModel!.data!.pagesBookmarks!.length ==0?

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border,color: MyColor.primaryColor,size: 70,),
                SizedBox(height: height*0.03,),
                BuildText(text: 'لا يوجد أي مقالة في المفضلة')
              ],
            ),
          )
              : Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*0.02),
            child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: width*0.5,
                    childAspectRatio: 3/4,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 0
                ),
                itemCount: cubit.bookMarksModel!.data!.pagesBookmarks!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return FadeInDown(
                      from : width*0.1,
                      child: buildItemFavourite(height, cubit, index, context, width));
                }),
          ),
        );
      },
    );
  }

  Padding buildItemFavourite(double height, AppCubit cubit, int index, BuildContext context, double width) {
    return Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*0.0),
                  child: GestureDetector(
                    onTap: (){
                      cubit.postPageDetails(id:  cubit.bookMarksModel!.data!.pagesBookmarks![index].pAGEID);
                      navigateTo(
                        context,
                        PageDetailsScreen(
                          title: cubit.bookMarksModel!.data!.pagesBookmarks![index].pageName!,
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: buildImage(
                                radius: 12,
                                image:  cubit.bookMarksModel!.data!.pagesBookmarks![index].pageDataFilename,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BuildText(
                                text: cubit.bookMarksModel!.data!.pagesBookmarks![index].pageName!,
                                bold: true,
                                size: 12,
                                center: true,
                              ),
                            ),
                          ],

                        ),
                        CashHelper.getData(key: 'login') == null? SizedBox() :
                        Positioned(
                          child: GestureDetector(
                            onTap: (){

                              cubit.postRemoveBookMarks(
                                  id: cubit.bookMarksModel!.data!.pagesBookmarks![index].pAGEID,
                              );
                              cubit.removeFromBookMarks(index);
                            },
                            child: SvgPicture.asset(
                              'assets/icons/fav.svg',
                              width: width*0.09,
                              color: Colors.red,
                              //semanticsLabel: 'A red up arrow'
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
  }
}
