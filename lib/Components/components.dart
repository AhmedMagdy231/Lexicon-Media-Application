import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../Constant/Colors/colors.dart';
import '../Screens/Login/login_screen.dart';

void navigateTo(context, widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigateToToFinish(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}


class ContainerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height -70);

    var firstStart = Offset(size.width * 0.5, size.height + 50);
    var firstend = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstend.dx, firstend.dy);
    var secandStart = Offset(size.width, size.height);
    var secandend = Offset(size.width, size.height);
    path.quadraticBezierTo(
        secandStart.dx, secandStart.dy, secandend.dx, secandend.dy);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

Shimmer buildLoading(double width, double height) {
  return buildShimmer(
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: width*0.02),
      child: GridView.builder(
          gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width*0.5,
              childAspectRatio: 3/4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 0
          ),
          itemCount: 10,
          itemBuilder: (BuildContext ctx, index) {
            return Padding(
              padding:  EdgeInsets.symmetric(vertical: height*0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height*0.2,
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

MaterialButton buildButton({Color? colorText, Color? color,required double width,required double height, required function,required text,required double size,double radius=15}) {
  return MaterialButton(
    onPressed: function,
    color: color == null?  MyColor.primaryColor: color,
    minWidth: width,
    height: height,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    child:  Text(
      text,
      style: GoogleFonts.notoSansArabic(
        color: colorText == null?  Colors.white : colorText,
        fontWeight: FontWeight.bold,
        fontSize: size,
      ),
    ),
  );
}


void showDialoog({
  required BuildContext context,
  required int num,
  required widget,
  String? action,
}) {
  AwesomeDialog(
    dismissOnBackKeyPress: true,
    context: context,
    dialogType: num == 1
        ? DialogType.success
        : num == 0
        ? DialogType.error
        : DialogType.warning,
    animType: AnimType.scale,
    btnOkText: 'موافق',
    title: 'Dialog Title',
    body: widget,
    btnOkColor: num == 1
        ? Colors.green
        : num == 0
        ? Colors.red
        : Color(0xffFFB61C),
    btnOkOnPress: () {
      if (action != null && action == 'verifycode') {
        Navigator.pop(context);
      }
    },
  ).show();
}


SnackBar buildSnackBar2(
    {required int num, required String title, required String message , milSecond =3000}) {
  return SnackBar(
    duration: Duration(milliseconds: milSecond),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: num == 0
          ? ContentType.failure
          : num == 1
          ? ContentType.success
          : ContentType.warning,
    ),
  );
}


Center buildOverlayLoading(double height) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitCubeGrid(
          color: MyColor.primaryColor,
          size: 50.0,
        ),
        SizedBox(
          height: height * 0.03,
        ),
        BuildText(
          text: 'جاري تحميل من فضلك انتظر'
              ,
          size: 18,
          //bold: true,
          color: Colors.white,
        ),
      ],
    ),
  );
}

LoaderOverlay buildGlobOverLay({required Widget widget}) {
  return LoaderOverlay(
    useDefaultLoading: false,
    overlayWidget: Center(
      child: SpinKitCubeGrid(
        color: MyColor.primaryColor,
        size: 50.0,
      ),
    ),
    overlayColor: Colors.black87,
    overlayOpacity: 0.8,
    child: widget,
  );
}

Shimmer buildShimmer({required child}) {
  return Shimmer.fromColors(
    child: child,
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
  );
}

Center buildLoadingWidget({double size =50}) {
  return Center(
    child: LoadingAnimationWidget.inkDrop(
      color: MyColor.primaryColor,
      size: size,
    ),
  );
}


ClipRRect buildImage({
  required image,
  double radius=0,
  String? fit,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: CachedNetworkImage(
      fit: fit == null?  BoxFit.fill:
      fit == 'cover'? BoxFit.cover: BoxFit.contain,
      imageUrl: image,
      placeholder: (context,url) => buildLoadingWidget(size: 40),
      errorWidget: (context,url,error) => Icon(Icons.error,color: Colors.red,),
    ),
  );
}


Center buildLoginFirst(double width, double height, BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width*0.7,
          height: width*0.7,
          child: SvgPicture.asset(
              'assets/images/login_or_signup.svg',
              semanticsLabel: 'Acme Logo'
          ),
        ),
        BuildText(
          text: 'تسجيل دخول أو انشاء حساب اولا',

        ),
        SizedBox(
          height: height*0.03,
        ),
        buildButton(
          width: width*0.8,
          height: height*0.05,
          function: (){
            navigateTo(
              context,
              LoginScreen(),
            );
          },
          text: 'اذهب لتسجيل الدخول أو الاشتراك',
          size: 15,

        ),
      ],
    ),
  );
}


TextFormField buildTextFormFieldNote({
  required controller,
  required valid,
  required hint,
  bool? description,
}) {
  return TextFormField(
    validator: valid,
    controller: controller,
    maxLines: description == null ? null : 10,
    decoration: InputDecoration(
        errorStyle: GoogleFonts.notoNaskhArabic(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        hintText: hint,
        hintStyle: GoogleFonts.notoNaskhArabic(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        border: description == null ? null : OutlineInputBorder()),
  );
}

String formatTime(timeStamp) {
  var TimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return DateFormat('hh:mm a').format(TimeStamp).toString();
}

Center buildNoItem(double width, double height,{required String name,required text, bool? color}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          name,
          width: width*0.35,
          color: color != null? null :  MyColor.primaryColor,
          //semanticsLabel: 'A red up arrow'
        ),
        SizedBox(height: height*0.02,),
        BuildText(
          text: text,
          color: Colors.grey,
          bold: true,


        ),
      ],
    ),
  );
}


Widget buildContainerStack({required height,required width,required context,required text}){
  return Stack(
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
            text: text,
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
  );
}