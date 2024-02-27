import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Network/Local/CashHelper.dart';
import 'package:education_application/Screens/Page%20Details/page_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class CategoryDetailsScreen extends StatefulWidget {
  late String categoryName;
  final context;

  CategoryDetailsScreen({required this.categoryName,required this.context});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    AppCubit.get(widget.context).categoryDetailsModel!.data!.subPagesCats!.length =0;
    AppCubit.get(widget.context).categoryDetailsModel!.data!.pages!.length =0;
    AppCubit.get(widget.context).postCategoryDetails(
        id: AppCubit.get(widget.context).categoryDetailsModel!.data!.pagesCat!.pARENTID,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener

        if(state is AddBookMarksSuccess){
          var snackBar = buildSnackBar2(
              num: 1,
              title: 'عمليه ناجحه',
              message: 'تم الإضافة بنجاح',
            milSecond: 800,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if(state is RemoveBookMarksSuccess){
          var snackBar = buildSnackBar2(
            num: 1,
            title: 'عمليه ناجحه',
            message: 'تم الحذف بنجاح',
            milSecond: 800,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {

        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: BuildText(
              text: widget.categoryName == ''?
              cubit.categoryDetailsModel == null? '':cubit.categoryDetailsModel!.data!.pagesCat!.pagescatTitle!:widget.categoryName,
              bold: true,
            ),
          ),
          body: cubit.categoryDetailsModel == null? buildLoading(width, height):
          cubit.categoryDetailsModel!.data!.pages!.length == 0 &&
              cubit.categoryDetailsModel!.data!.subPagesCats!.length == 0?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.bookOpen,color: MyColor.primaryColor,size: 70,),
                SizedBox(height: height*0.03,),
                BuildText(text: 'لا يوجد صفحات في هذا القسم حتي الان')
              ],
            ),
          ) :
          cubit.categoryDetailsModel!.data!.subPagesCats!.length == 0?
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*0.02),
            child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: height*0.3,
                    crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 2

                ),
                itemCount: cubit.categoryDetailsModel!.data!.pages!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*0.0),
                    child: GestureDetector(
                      onTap: (){
                        cubit.postPageDetails(id: cubit.categoryDetailsModel!.data!.pages![index].pAGEID);
                        navigateTo(
                          context,
                          PageDetailsScreen(
                            title: cubit.categoryDetailsModel!.data!.pages![index].pageName!,
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
                                    image: cubit.categoryDetailsModel!.data!.pages![index].pagespostFilename,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BuildText(
                                    text: cubit.categoryDetailsModel!.data!.pages![index].pageName!,
                                    bold: true,
                                    size: 12,
                                    center: true,
                                ),
                              ),
                            ],

                          ),

                        // Positioned(
                        //       child: IconButton(
                        //         onPressed: (){
                        //            if( cubit.categoryDetailsModel!.data!.pages![index].pageBookmarked == 1){
                        //              cubit.categoryDetailsModel!.data!.pages![index].pageBookmarked = 0;
                        //
                        //              cubit.postRemoveBookMarks(
                        //                  id: cubit.categoryDetailsModel!.data!.pages![index].pAGEID,
                        //              );
                        //            }
                        //            else
                        //              {
                        //                cubit.categoryDetailsModel!.data!.pages![index].pageBookmarked = 1;
                        //                cubit.postAddBookMarks(
                        //                  id: cubit.categoryDetailsModel!.data!.pages![index].pAGEID,
                        //                );
                        //              }
                        //         },
                        //         icon: Icon(
                        //           cubit.categoryDetailsModel!.data!.pages![index].pageBookmarked ==1?
                        //               Icons.bookmark :  Icons.bookmark_border,
                        //             size: 30,
                        //           color: cubit.categoryDetailsModel!.data!.pages![index].pageBookmarked ==1?
                        //           MyColor.primaryColor : Colors.grey ,
                        //         ),
                        //       ),
                        //   )
                        ],
                      ),
                    ),
                  );
                }),
          ):
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: width*0.02),
            child: GridView.builder(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: height*0.35,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 2,
                ),
                itemCount: cubit.categoryDetailsModel!.data!.subPagesCats!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: height*0.0),
                    child: GestureDetector(
                      onTap: (){

                        String name = cubit.categoryDetailsModel!.data!.subPagesCats![index].pagescatTitle!;
                        cubit.postCategoryDetails(id: cubit.categoryDetailsModel!.data!.subPagesCats![index].pAGESCATID);
                        navigateTo(
                          context,
                          CategoryDetailsScreen(
                            categoryName: name,
                            context: context,
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height*0.05,
                          ),
                          Container(
                            height: height*0.2,
                            child: buildImage(
                              radius: 12,
                              image: cubit.categoryDetailsModel!.data!.subPagesCats![index].pagescatPhoto,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BuildText(
                              text: cubit.categoryDetailsModel!.data!.subPagesCats![index].pagescatTitle!,
                              bold: true,
                              size: 12,
                              center: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
