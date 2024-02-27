import 'dart:math';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Components/TextField/text_form_field.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Screens/Home%20layout/home_layour_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Components/Text/text.dart';
import '../../Cubits/App Cubit/app_cubit.dart';
import '../../Network/Local/CashHelper.dart';
import '../../generated/l10n.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  var pin = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  bool show = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener

        if(state is ResetPasswordSuccess){

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
          else
          {
            CashHelper.putData(key: 'login', value: true);
            CashHelper.putData(key: 'token', value: state.token);
            AppCubit.get(context).postUserData(token: state.token);
           Navigator.pop(context);
           Navigator.pop(context);
           Navigator.pop(context);
            var snackBar = buildSnackBar2(
                num: 1,
                title:
                'عمليه ناجحه',
                message: state.messages[0],
            );

            ScaffoldMessenger.of(
                context)
                .showSnackBar(snackBar);
          }




        }





      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
             'رمز التحقق',
              style: GoogleFonts.notoKufiArabic(
                color: Colors.white,
              ),
            ),
            elevation: 10,
            backgroundColor: MyColor.primaryColor,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*0.07,),
              child: Form(
                key: formKey,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height*0.1,),
                    CircleAvatar(
                        backgroundColor: MyColor.primaryColor,
                        radius: 100,
                        backgroundImage: AssetImage('assets/images/forget.gif')),
                    SizedBox(height: height*0.06,),
                    BuildText(
                      text : 'من فضلك ادخل رمز التحقق المرسل اولا بعد ذلك كلمة المرور الجديدة',
                      center: true,
                      bold: true,
                      size: 16,
                    ),
                    SizedBox(height: height*0.06,),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        validator: (value){
                          if(value!.isEmpty){
                             return 'من فضلك أدخل رمز التحقق';
                          }
                        },
                        controller: pin,
                        length: 6,
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


                        },
                        onChanged: (value) {

                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      ),
                    ),
                    SizedBox(height: height*0.03,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        boxShadow:  [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 12,
                              spreadRadius: 1,
                              offset: Offset(0, 2)),
                        ],
                      ),
                      child: BuildTextFormField(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          },
                          icon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              show
                                  ? FontAwesomeIcons.eye
                                  : FontAwesomeIcons.eyeSlash,
                              color: MyColor.primaryColor,
                            ),
                          ),
                        ),
                        isPassword: !show,
                        keyboardType: TextInputType.emailAddress,
                        controller: passwordController,
                        hintText: S.of(context).login_password,
                        prefixIcon: FontAwesomeIcons.lock,
                        valid: (value){
                          if(value!.isEmpty){
                            return S.of(context).login_email_valid;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: height*0.06,),


                   state is ResetPasswordLoading? Center(
                     child: CircularProgressIndicator(
                       color: MyColor.primaryColor,
                     ),
                   ) : buildButton(
                      width: width*0.8,
                      height: height*0.06,
                      function: (){
                        if(formKey.currentState!.validate()){
                          cubit.postRestPassword(
                              id: cubit.forgetPasswordModel!.data!.student_uniqueid!,
                              code: pin.text,
                              password: passwordController.text,
                          );
                        }
                      },
                      text: S.of(context).forget_password_button,
                      size: 18,
                    ),
                    SizedBox(height: height*0.06,),


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
