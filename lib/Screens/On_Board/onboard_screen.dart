import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Screens/Login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Components/components.dart';
import '../../Network/Local/CashHelper.dart';
import '../Home layout/home_layour_screen.dart';
import 'data_onBoard.dart';


class OnBoardScreen extends StatefulWidget {


  OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final List<OnBoard> _onBoardList = [
    OnBoard(image: 'assets/images/onboard1.png',
        title: "مرحبا بك في المعجم الاعلامي",
        description: "إن هذه العربية بنيت على أصل سحري يجعل شبابها خالدًا عليها فلا تهرم ولا تموت، لأنها أعدت من الأزل فَلكًا دائِرا للنيِّرين الأرضيين العظيمين (كتاب الله وسنة رسوله)، ومِن ثَمَّ كانت فيها قوة عجيبة من الاستهواء كأنها أخذة السحر."),
    OnBoard(image: 'assets/images/onboard2.png',
        title: "مرحبا بك في المعجم الاعلامي",
        description: "بلغت العربية بفضل القرآن من الاتساع مدىً لا تكاد تعرفه أيُّ لغةٍ أخرى من لغات الدنيا، والمسلمون جميعًا مؤمنون بأن العربية وحدها اللسانُ الذي أُحِلّ لهم أن يستعملوه في صلاتهم"),
    OnBoard(image: 'assets/images/onboard3.png',
        title: "مرحبا بك في المعجم الاعلامي",
        description: "إن اللغة العربية لم تتقهقهر في ما مضى أمام أي لغة أخرى من اللغات التي احتكت بها، وينتظر أن تحافظ على كيانها في المستقبل كما حافظت عليه في الماضي وللغة العربية لين ومرونة يمكنانها من التكيف لمقتضيات هذا العصر."),
  ];
  bool isLast = false;

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    navigateToToFinish(context, HomeLayout());
                  },
                  child: Text('تخطي', style: GoogleFonts.openSans(
                      color: MyColor.primaryColor, fontSize: 20),)
              ),

              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    isLast = index == _onBoardList.length - 1 ? true : false;
                  },
                  controller: boardController,
                  itemBuilder: (context, index) {
                    return buildOnBoardItem(height, _onBoardList[index]);
                  },
                  itemCount: 3,
                ),
              ),

              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: MyColor.primaryColor,
                      dotHeight: 12,
                      dotWidth: 12,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                  ),
                  const Spacer(),

                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        CashHelper.putData(key: 'firstTime', value: true);
                        navigateToToFinish(context, HomeLayout());
                      };
                      boardController.nextPage(duration: const Duration(
                        milliseconds: 750,
                      ),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_rounded, color: Colors.white,),
                    backgroundColor: MyColor.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildOnBoardItem(double height, OnBoard item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(item.image, width: double.infinity, height: height * 0.3,),
        SizedBox(
          height: height * 0.06,
        ),
       BuildText(
         text: item.title,
         color: MyColor.primaryColor,
         bold: true,
       ),
        SizedBox(
          height: height * 0.02,
        ),
        BuildText(
          text: item.description,
          center: true,
          size: 18,
        ),
      ],
    );
  }
}
