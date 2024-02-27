import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/Auth%20Cubit/auth_cubit.dart';
import 'package:education_application/Network/Local/CashHelper.dart';
import 'package:education_application/Screens/Home%20layout/home_layour_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


import '../../Components/Text/text.dart';
import '../../Components/components.dart';
import '../../Cubits/App Cubit/app_cubit.dart';

class OTPScreen extends StatelessWidget {
  late String email;
  late String id;
   OTPScreen({required this.email,required this.id });
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return buildGlobOverLay(
      widget: BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    // TODO: implement listener
      if(state is OTPLoading){
        context.loaderOverlay.show(widget: buildOverlayLoading(height));
        Future.delayed(Duration(seconds: 5),(){
          if(context.loaderOverlay.visible){
            context.loaderOverlay.hide();
          }
        });
      }
      if(state is OTPSuccess){
        context.loaderOverlay.hide();
        if(state.hasError){
          var snackBar = buildSnackBar2(
              num: 0,
              title:
              'عمليه غير ناجحه',
              message: state.errors[0]);
          ScaffoldMessenger.of(
              context)
              .showSnackBar(snackBar);
        }
        else{
          CashHelper.putData(key: 'login', value: true);
          CashHelper.putData(key: 'token', value: state.token);
          AppCubit.get(context).postUserData(token: state.token);
          Navigator.pop(context);
       //   navigateToToFinish(context, HomeLayout());
          var snackBar = buildSnackBar2(
              num: 1,
              title:
              'عمليه ناجحه',
              message: state.messages![0]);
          ScaffoldMessenger.of(
              context)
              .showSnackBar(snackBar);
          navigateToToFinish(context, HomeLayout());
        }
      }


  },
  builder: (context, state) {
      var cubit = AuthCubit.get(context);
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                clipper: ContainerCliper(),
                child: Container(
                  width: width,
                  height: height * 0.4,
                  decoration: BoxDecoration(
                      color: MyColor.primaryColor,
                      image: const DecorationImage(
                          image: AssetImage('assets/images/otp.png'),
                          fit: BoxFit.cover)),
                ),
              ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height*0.03,),
                  BuildText(
                    text: 'من فضلك أدخل رقم التحقق المرسل الي البريد الاكتروني',
                    size: 20,
                    bold: true,
                  ),
                  SizedBox(height: height*0.03,),
                  BuildText(
                      text: 'لقد تم ارسال رمز من 6 ارقام علي البريد الاكتروني',
                      size: 13,
                      color: Colors.grey,
                     bold: true,
                  ),
                  SizedBox(height: height*0.01,),
                  BuildText(
                    text: email,
                    size: 20,
                    color: Colors.black,
                    bold: true,
                  ),
                  SizedBox(height: height*0.05,),
                  BuildText(
                    text: 'أدخل الرمز المرسل',
                    size: 20,

                    color: Colors.black,
                    bold: true,
                  ),
                  SizedBox(height: height*0.02,),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      controller: controller,
                      length: 6,
                      autoFocus: true,
                      cursorColor: MyColor.primaryColor,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      animationType: AnimationType.scale,
                      textStyle: const TextStyle(fontSize: 18.0,color: Colors.black),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        borderWidth: 1.0,
                        activeColor:MyColor.primaryColor,
                        inactiveColor: Colors.grey,
                        inactiveFillColor: Colors.transparent,
                        activeFillColor: Colors.transparent,
                        selectedColor: MyColor.primaryColor,
                        selectedFillColor: Colors.transparent,
                      ),
                      animationDuration:
                      const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      backgroundColor: Colors.transparent,
                      onCompleted: (value) {
                        cubit.postLoginVerify(id, value);

                      },
                      onChanged: (value) {

                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                  ),
                ],
              ),
            ),

            ],
          ),
        ),

      );
  },
),
    );
  }
}
