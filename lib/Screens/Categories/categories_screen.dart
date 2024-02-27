import 'package:animate_do/animate_do.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Screens/Category%20Details/category_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
   CategoriesScreen({Key? key}) : super(key: key);

  String image = 'https://img.freepik.com/free-vector/school-supplies-blackboard_23-2148587747.jpg?w=900&t=st=1697554026~exp=1697554626~hmac=3bffd5d0373fb0c7e755c34f4ed97edfd36fd52856c2cd524940fda696227368';

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
          body: cubit.categoryModel == null
              ? buildLoading(width, height)
              : ListView.builder(
                  itemBuilder: (context, index) {

                    return index % 2 == 0 ?
                    FadeInRight(
                      from: width/2,
                      duration: Duration(milliseconds: 500),
                      child: GestureDetector(
                        onTap: (){
                          cubit.postCategoryDetails(id: cubit.categoryModel!.data!.pages_cat[index].CID);
                          navigateTo(
                              context,
                              CategoryDetailsScreen(
                                categoryName: cubit.categoryModel!.data!.pages_cat![index].cat_title,
                                context: context,
                              )
                          );
                        },
                        child: Container(
                          height: height*0.16,
                          width: width,
                          child: Stack(
                            children: [

                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: height*0.1,
                                  width: width,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            MyColor.primaryColor,

                                            Colors.black,
                                          ]
                                      )
                                  ),
                                  child:  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                                    child: BuildText(
                                      text: cubit.categoryModel!.data!.pages_cat[index]
                                          .cat_title,
                                      color: Colors.white,
                                      bold: true,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,

                                child: SizedBox(
                                  width: width*0.3,

                                  child:   Image.network(
                                    cubit.categoryModel!.data!.pages_cat[index].pagescat_icon,
                                   ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ) :
                    FadeInLeft(
                      from: width/2,
                      duration: Duration(milliseconds: 500),
                      child: GestureDetector(
                        onTap: (){
                          cubit.postCategoryDetails(id: cubit.categoryModel!.data!.pages_cat[index].CID);
                          navigateTo(
                              context,
                              CategoryDetailsScreen(
                                categoryName: cubit.categoryModel!.data!.pages_cat![index].cat_title,
                                context: context,
                              )
                          );
                        },
                        child: Container(

                          height: height*0.16,
                          width: width,

                          child: Stack(
                            children: [

                              Positioned(
                                bottom: 0,
                                child: Container(

                                  height: height*0.1,
                                  width: width,
                                  decoration: BoxDecoration(

                                    gradient: LinearGradient(
                                      colors: [
                                        MyColor.primaryColor,

                                        Colors.black,
                                      ]
                                    )
                                  ),
                                  child:  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.02),
                                    child: BuildText(
                                      text: cubit.categoryModel!.data!.pages_cat[index]
                                          .cat_title,
                                      color: Colors.white,
                                      bold: true,
                                      size: 17,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,


                                child: SizedBox(
                                  width: width*0.35,
                                  child:  Image.network(
                                    cubit.categoryModel!.data!.pages_cat[index].pagescat_icon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  },
                  itemCount: cubit.categoryModel!.data!.pages_cat.length,
                ),
        );
      },
    );
  }




  ListView buildLoading(double width, double height) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildShimmer(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.005),
            child: Container(
              width: width,
              height: height * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
      itemCount: 5,
    );
  }
}
/*
       itemBuilder: (context, index) {
                    return index %2 ==0? FadeInRight(
                      from: width/2,
                        duration: Duration(milliseconds: 500),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02, vertical: height * 0.009),
                          child: GestureDetector(
                            onTap: () {
                              cubit.postCategoryDetails(id: cubit.categoryModel!.data!.pages_cat[index].CID);
                              navigateTo(
                                  context,
                                  CategoryDetailsScreen(
                                      categoryName: cubit.categoryModel!.data!.pages_cat![index].cat_title,
                                    context: context,
                                  )
                              );
                            },
                            child: Container(
                              width: width,
                              height: height * 0.18,

                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: height*0.18,
                                    width: width,
                                    child: buildImage(
                                      image: image,
                                      radius: 15,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.black54,
                                    ),

                                  ),
                                  Center(
                                    child: BuildText(
                                      text: cubit.categoryModel!.data!.pages_cat[index]
                                          .cat_title,
                                      color: Colors.white,
                                      bold: true,
                                      size: 20,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                    ) :
                    FadeInLeft(
                      duration: Duration(milliseconds: 500),
                      from: width/2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02, vertical: height * 0.009),
                        child: GestureDetector(
                          onTap: () {
                            cubit.postCategoryDetails(id: cubit.categoryModel!.data!.pages_cat[index].CID);
                            navigateTo(
                                context,
                                CategoryDetailsScreen(
                                    categoryName: cubit.categoryModel!.data!.pages_cat![index].cat_title,
                                    context: context,
                                ),
                            );
                          },
                          child: Container(
                            width: width,
                            height: height * 0.18,

                            child: Stack(
                              children: [
                                SizedBox(
                                  height: height*0.18,
                                  width: width,
                                  child: buildImage(
                                    image: image,
                                    radius: 15,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black38,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.black54,
                                  ),

                                ),
                                Center(
                                  child: BuildText(
                                    text: cubit.categoryModel!.data!.pages_cat[index]
                                        .cat_title,
                                    color: Colors.white,
                                    bold: true,
                                    size: 20,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );

                  },
 */