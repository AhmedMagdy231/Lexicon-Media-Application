import 'package:animate_do/animate_do.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../Components/Text/text.dart';
import '../../Components/components.dart';
import '../Page Details/page_details_screen.dart';

class SearchScreen extends StatefulWidget {
   SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit  = AppCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        child: Container(
          width: width,
          height: height,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height*0.25,
                decoration:  BoxDecoration(
                  color: MyColor.primaryColor,
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/search.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      },icon:Icon(Icons.arrow_back,color: Colors.white,),),

                      FadeInUp(
                        from: height*0.1,
                        child: Container(
                          width: width*0.75,
                          height: height*0.065,
                          child: TextField(
                            onChanged: (value){
                              if(value.isEmpty == false){
                                cubit.postSearch(value: value);
                              }
                              else{
                                setState(() {
                                  cubit.searchModel = null;
                                });
                              }

                            },

                            controller: cubit.searchController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search,color: Colors.grey,),
                              filled: true,
                              hintText: 'أبحث عن مقالات...',
                              hintStyle: GoogleFonts.notoKufiArabic(
                                color: Colors.grey
                              ),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)
                              ),
                            ),
                          ),
                        ),
                      ),




                    ],
                  ),
                ),

              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                  child: Container(
                    height: height*0.80,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      )
                    ),

                    child: cubit.searchModel == null?
                        Center(
                          child: Image.asset('assets/images/empty_search.png'),
                        )
                        :
                        state is SearchLoading? buildLoading(width, height):
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width*0.02),
                      child: GridView.builder(
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: height*0.2,
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 2

                          ),
                          itemCount: cubit.searchModel!.data!.pages!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding:  EdgeInsets.symmetric(vertical: height*0.0),
                              child: GestureDetector(
                                onTap: (){
                                  cubit.postPageDetails(id: cubit.searchModel!.data!.pages![index].pAGEID);
                                  navigateTo(
                                    context,
                                    PageDetailsScreen(
                                      title: cubit.searchModel!.data!.pages![index].pageName!,
                                    ),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Container(

                                      child: buildImage(
                                        radius: 12,
                                        image: cubit.searchModel!.data!.pages![index].pagespostFilename,
                                      ),
                                      height: height*0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),

                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: BuildText(
                                        text: cubit.searchModel!.data!.pages![index].pageName!,
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  },
);
  }

   Shimmer buildLoading(double width, double height) {
     return buildShimmer(
       child: Padding(
         padding:  EdgeInsets.symmetric(horizontal: width*0.02),
         child: GridView.builder(
             gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                 mainAxisExtent: height*0.2,
                 crossAxisCount: 3,
                 crossAxisSpacing: 5,
                 mainAxisSpacing: 2

             ),
             itemCount: 10,
             itemBuilder: (BuildContext ctx, index) {
               return Padding(
                 padding:  EdgeInsets.symmetric(vertical: height*0.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       height: height*0.1,
                       decoration: BoxDecoration(
                         color: Colors.grey,
                         borderRadius: BorderRadius.circular(12),

                       ),
                     ),
                     SizedBox(height: height*0.02,),
                     Container(
                       height: height*0.02,
                       width: width*0.3,
                       decoration: BoxDecoration(
                         color: Colors.grey,
                         borderRadius: BorderRadius.circular(12),

                       ),
                     ),

                   ],

                 ),
               );
             }),
       ),
     );
   }
}
