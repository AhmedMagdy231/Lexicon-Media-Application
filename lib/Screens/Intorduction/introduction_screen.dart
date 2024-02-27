import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';

import 'package:education_application/Screens/On_Board/onboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../generated/l10n.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height/1.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
              ),
            ),
            Container(
              width: width,
              height: height/1.6,
              decoration: BoxDecoration(
                color: MyColor.primaryColor,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
              ),
              child: Center(
                child: Image.asset('assets/images/books.png',scale: 0.8,),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: height/2.66,
                decoration: BoxDecoration(
                  color: MyColor.primaryColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: height/2.66,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:  BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: height*0.05,horizontal: width*0.05),
                  child: Column(
                    children: [
                      BuildText(
                       text: 'قال الشافعي',
                       size: 20,
                        bold: true,
                      ),
                      SizedBox(height: height*0.02,),
                      BuildText(
                      text: " أصحاب العربية جن الإنس يبصرون ما لا يبصر غيرهم من كتاب آداب الشافعي ومناقبه، عبدالرحمن أبي حاتم الرازي، تحقيق عبدالغني عبدالخالق",
                      center: true,
                        color: Colors.grey.shade600,
                      ),

                      Spacer(),
                      buildButton(width: width*0.6,height: height*0.06,text: S.of(context).introduction_button,size: 18,function: (){
                        navigateTo(context, OnBoardScreen());
                      }),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
