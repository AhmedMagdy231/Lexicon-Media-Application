import 'package:animate_do/animate_do.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Cubits/Auth%20Cubit/auth_cubit.dart';
import 'package:education_application/Network/Local/CashHelper.dart';
import 'package:education_application/Screens/Login/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';


import '../../Components/DropDownButtonField/drop_down_button_filed.dart';
import '../../Components/Text/text.dart';
import '../../Components/components.dart';
import '../../Constant/Colors/colors.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener

        if(state is ChangeProfileLoading){
          context.loaderOverlay.show(widget: buildOverlayLoading(height));
        }
        if(state is ChangeProfileSuccess){
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

            var snackBar = buildSnackBar2(
                num: 1,
                title:
                'عمليه ناجحه',
                message: state.messages![0]);
            ScaffoldMessenger.of(
                context)
                .showSnackBar(snackBar);

          }
        }

      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return buildGlobOverLay(
          widget: Scaffold(
            body:  CashHelper.getData(key: 'login') == null?
                buildLoginFirst(width, height, context)
                : cubit.userModel == null? buildLoadingWidget() : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: height * 0.25,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: ContainerCliper(),
                          child: Container(
                            width: width,
                            height: height * 0.17,
                            decoration: BoxDecoration(
                              color: MyColor.primaryColor,

                            ),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          height: height * 0.1,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: BuildText(
                              text: '',
                              bold: true,
                              size: 25,
                              color: Colors.white,
                              center: true,
                            ),
                          ),
                        ),
                        Positioned(
                          top: height * 0.005,
                          left: width / 2 - width * 0.3,

                          child: AvatarGlow(
                            glowColor: Colors.white,
                            endRadius: width*0.3,
                            duration: const Duration(milliseconds: 1500),
                            repeat: true,
                            showTwoGlows: true,
                            repeatPauseDuration:const Duration(milliseconds: 100),
                            child: GestureDetector(
                              onTap: () {
                                //

                                showDialog(
                                    context: context,
                                    builder: (_){
                                      return AlertDialog(

                                        contentPadding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero, // Set the border radius to zero
                                          ),

                                        content: Hero(
                                          tag: 'hom',
                                          child: SizedBox(
                                            child: cubit.image == null ?
                                            Image.network(
                                                cubit.userModel!.data!.student!.studentPic!,
                                                fit: BoxFit.cover,
                                            )
                                                : Image.file(
                                                cubit.image!,
                                              fit: BoxFit.contain,

                                            ),
                                          ),
                                        ),
                                        actionsPadding: EdgeInsets.symmetric(vertical: height*0.005),
                                        actions: [
                                           Center(
                                             child: buildButton(
                                                 width: width*0.3,
                                                 height: height*0.05,
                                                 function: (){
                                                   cubit.pickImage(ImageSource.gallery);
                                                 },
                                                 text: 'تغير الصوره',
                                                 size: 12,
                                             ),
                                           ),
                                        ],
                                      );
                                    }
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyColor.primaryColor,
                                ),
                                padding: EdgeInsets.all(width * 0.015),
                                child: cubit.image == null ? FadeInDown(
                                  from: height*0.02,
                                  child: CircleAvatar(
                                    radius: width * 0.18,
                                    backgroundImage: NetworkImage(
                                        cubit.userModel!.data!.student!.studentPic!),
                                  ),
                                ) : FadeInDown(
                                  from: height*0.02,
                                  child: CircleAvatar(
                                    radius: width * 0.18,
                                    backgroundImage: FileImage(cubit.image!),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: height*0.25,
                        //   left: width/2 + width*0.1,
                        //   child: Container(
                        //     width: 40,
                        //     decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Colors.grey,
                        //     ),
                        //     child: IconButton(
                        //       onPressed: (){},
                        //       icon: Icon(Icons.edit,color: Colors.white,size: 30,),
                        //       padding: EdgeInsets.all(0),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: BuildText(
                                text: cubit.userModel!.data!.student!.studentName!,
                                bold: true,
                                size: 25,
                                center: true,
                              ),
                            ),
                          ),
                          // Container(
                          //   width: width,
                          //   child: FittedBox(
                          //     fit: BoxFit.scaleDown,
                          //     child: BuildText(
                          //       text: cubit.userModel!.data!.student!.studentEmail!,
                          //       size: 20,
                          //       center: true,
                          //       color: Colors.grey,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          buildEditTextFormField(
                            cubit: cubit,
                            height: height,
                            title: 'الاسم',
                            controller: cubit.nameController,
                            valid: (value){
                              if(value!.isEmpty){
                                return 'من فضلك ادخل الاسم';
                              }
                            }
                          ),
                          buildEditTextFormField(
                            cubit: cubit,
                            height: height,
                            title: 'البريد الاكتروني',
                            controller: cubit.emailController,
                              valid: (value){
                                if(value!.isEmpty){
                                  return 'من فضلك ادخل البريد الاكتروني';
                                }
                              }
                          ),
                          buildEditTextFormField(
                            cubit: cubit,
                            height: height,
                            title: 'رقم الهاتف',
                            controller: cubit.phoneController,
                              valid: (value){
                                if(value!.isEmpty){
                                  return 'من فضلك ادخل رقم الهاتف';
                                }
                              }
                          ),
                          buildEditTextFormField(
                            ontap: (){
                              showDatePicker(
                                locale: Locale('en'),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme:  ColorScheme.light(
                                        primary: MyColor.primaryColor,
                                        // <-- SEE HERE
                                        onPrimary: Colors.white,
                                        // <-- SEE HERE
                                        onSurface: MyColor.primaryColor, // <-- SEE HERE
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.parse('1980-01-01'),
                                lastDate: DateTime.now(),
                                cancelText: '',
                              ).then((value) {
                                //print(value);
                                cubit.birthdateController.text = DateFormat('yyyy-MM-dd').format(value!);
                                print(cubit.birthdateController.text);
                                FocusScope.of(context).unfocus();
                              });
                            },
                            cubit: cubit,
                            height: height,
                            title: 'تاريخ الميلاد',
                            controller: cubit.birthdateController,
                              valid: (value){
                                if(value!.isEmpty || value == '0000-00-00'){
                                  return 'من فضلك ادخل تاريخ الميلاد';
                                }
                              }
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: height * 0.01),
                            child: BuildText(
                              text: 'الوظيفة',
                              bold: true,
                              size: 15,
                              color: MyColor.primaryColor,
                            ),
                          ),
                          BuildDropDownButtonField(
                            cubit: cubit,
                            height: height,
                            width: width,
                            hint: cubit.jobController.text == ''
                                ? 'أختر الوظيفة'
                                : cubit.jobController.text,
                            valid: cubit.jobController.text != ''? null : (value) {
                              if (value == null) {
                                return 'من فضلك أختر الوظيفة';
                              }
                            },
                            item: cubit.jobsModel == null ? [] : cubit
                                .jobsModel!.data!.jobsList,
                            num: 4,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: height * 0.01),
                            child: BuildText(
                              text: 'المحافظة',
                              bold: true,
                              size: 15,
                              color: MyColor.primaryColor,
                            ),
                          ),
                          BuildDropDownButtonField(
                            cubit: cubit,
                            height: height,
                            width: width,
                            hint: cubit.regionController.text,
                            valid: cubit.regionController.text != ''? null :  (value) {
                              if (value == null) {
                                return 'من فضلك أختر المحافظة';
                              }
                            },
                            item: cubit.regionsModel == null ? [] :
                            cubit.regionsModel!.data!.regionsList,
                            num: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: height * 0.01),
                            child: BuildText(
                              text: 'الجامعة',
                              bold: true,
                              size: 15,
                              color: MyColor.primaryColor,
                            ),
                          ),
                          BuildDropDownButtonField(
                            cubit: cubit,
                            height: height,
                            width: width,
                            hint: cubit.universityController.text,
                            valid: cubit.universityController.text != ''? null :(value) {
                              if (value == null) {
                                return 'من فضلك أختر الجامعة';
                              }
                            },
                            item: cubit.universitiesModel == null ? [] : cubit
                                .universitiesModel!.data!.universitiesNames,
                            num: 3,
                          ),
                          SizedBox(height: height * 0.03,),
                          Center(
                            child: buildButton(
                              width: width * 0.6,
                              height: height * 0.05,
                              function: () {
                                  if(formKey.currentState!.validate()){
                                    cubit.postChangeProfile(
                                      studentRegionID: cubit.regionController.text,
                                      studentJOBID: cubit.jobController.text,
                                      universityId: cubit.universityController.text,
                                      student_name: cubit.nameController.text,
                                      student_birthdate: cubit.birthdateController.text,
                                      student_email: cubit.emailController.text,
                                    );
                                  }
                              },
                              text: 'تعديل',
                              size: 20,
                            ),
                          ),
                          SizedBox(height: height * 0.03,),
                        ],
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



  Widget buildEditTextFormField({
    required AppCubit cubit,
    required double height,
    required controller,
    required title,
    required String? Function(String?)? valid,
    Function()? ontap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: BuildText(
              text: title,
              bold: true,
              size: 15,
              color: MyColor.primaryColor,
            ),
          ),
          TextFormField(
            onTap: ontap,
            validator: valid,
            controller: controller,
            style: GoogleFonts.notoSansArabic(
              //  fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(height * 0.02),
              //  prefixIcon: Icon(FontAwesomeIcons.user,color: MyColor.primaryColor,),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: MyColor.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
