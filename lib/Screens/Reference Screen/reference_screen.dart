import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constant/Colors/colors.dart';

class ReferenceScreen extends StatelessWidget {
  const ReferenceScreen({Key? key}) : super(key: key);

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
      body: Column(
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
                    text: 'روابط خارجية',
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
            child: ListView.builder(
                itemBuilder: (context,index){
                  return Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(

                      children: [
                        SizedBox(width: width*0.02,),
                        SvgPicture.asset(
                          'assets/icons/link.svg',
                          width: 20,
                          color: Colors.black,
                          //semanticsLabel: 'A red up arrow'
                        ),
                        Expanded(
                          child: TextButton(
                              onPressed: (){
                                String url = cubit.pageDetailsModel!.data!.externalPagesUrls![index].pagesurlValue!;
                                final Uri _url = Uri.parse(url);
                                launchUrl(_url, mode: LaunchMode.externalApplication);
                              },
                              child: BuildText(
                                text:  cubit.pageDetailsModel!.data!.externalPagesUrls![index].pagesurlValue!,
                                color: MyColor.primaryColor,
                                maxLines: 1,
                                overflow: true,
                              )
                          ),
                        ),
                      ],
                    ),
                  );
                },
              itemCount: cubit.pageDetailsModel!.data!.externalPagesUrls!.length,
              
            ),
          )
        ],
      ),

    );
  },
);
  }
}
