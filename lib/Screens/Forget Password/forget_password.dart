import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Components/TextField/text_form_field.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../Components/Text/text.dart';
import '../../Cubits/App Cubit/app_cubit.dart';
import '../../generated/l10n.dart';
import '../Reset Password/reset_password_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
    if(state is ForgetPasswordSuccess){

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
          navigateTo(context, ResetPasswordScreen());
          var snackBar = buildSnackBar2(
              num: 1,
              title:
              'عمليه ناجحه',
              message: 'سوف يتم ارسال الكود علي البريد الاكتروني');

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
          S.of(context).login_forget_password,
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
                SizedBox(height: height*0.13,),
                CircleAvatar(
                     backgroundColor: MyColor.primaryColor,
                    radius: 100,
                    backgroundImage: AssetImage('assets/images/forget.gif')),
                SizedBox(height: height*0.06,),
               BuildText(
                 text : 'الرجاء ادخال البريد الاكتروني الخاص بك لي تحصل علي رمز التحقق',
                 center: true,
                 bold: true,
                 size: 16,
               ),
                SizedBox(height: height*0.06,),
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
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hintText: S.of(context).login_email,
                    prefixIcon: FontAwesomeIcons.envelope,
                    valid: (value){
                      if(value!.isEmpty){
                        return S.of(context).login_email_valid;
                      }
                    },
                  ),
                ),
                SizedBox(height: height*0.06,),

               state is ForgetPasswordLoading? buildLoadingWidget():   buildButton(
                    width: width*0.8,
                    height: height*0.06,
                    function: (){
                      if(formKey.currentState!.validate()){
                          cubit.postForgetPassword(
                            email: emailController.text,
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
