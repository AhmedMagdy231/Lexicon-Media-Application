import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Components/DropDownButtonField/drop_down_button_filed.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Cubits/Auth%20Cubit/auth_cubit.dart';
import 'package:education_application/Screens/Login/login_screen.dart';
import 'package:education_application/Screens/OTP/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../Components/TextField/text_form_field.dart';
import '../../Components/components.dart';
import '../../Constant/Colors/colors.dart';
import '../../generated/l10n.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  bool show = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return buildGlobOverLay(
      widget: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
            if(state is RegisterLoading){
              context.loaderOverlay.show(widget: buildOverlayLoading(height));
            }
            if(state is RegisterSuccess){
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
                navigateTo(context, OTPScreen(email: emailController.text,id: cubit.registerModel!.data!.studentUniqueid!,));
              }
            }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xffF9F8FD),
            //0xffEDEDF5
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: ContainerCliper(),
                    child: Container(
                      width: width,
                      height: height * 0.2,
                      decoration: BoxDecoration(
                        color: MyColor.primaryColor,
                        image: const DecorationImage(
                            image: AssetImage('assets/images/register.png'),
                            fit: BoxFit.contain
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Text(
                            S
                                .of(context)
                                .login_sign_up,
                            style: GoogleFonts.openSans(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            child: BuildTextFormField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return S
                                      .of(context)
                                      .register_name_valid;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              controller: nameController,
                              hintText: S
                                  .of(context)
                                  .register_name,
                              prefixIcon: FontAwesomeIcons.user,


                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 30,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0)),
                              ],
                            ),
                            child: BuildTextFormField(
                                controller: phoneController,
                                hintText: S
                                    .of(context)
                                    .login_phone_number,
                                prefixIcon: FontAwesomeIcons.mobileAlt,
                                keyboardType: TextInputType.phone,
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return S
                                        .of(context)
                                        .login_phone_number_valid;
                                  }
                                  return null;
                                }),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 30,
                                    spreadRadius: 1,
                                    offset: Offset(0, 0)),
                              ],
                            ),
                            child: BuildTextFormField(
                                controller: emailController,
                                hintText: S
                                    .of(context)
                                    .login_email,
                                prefixIcon: FontAwesomeIcons.envelope,
                                keyboardType: TextInputType.emailAddress,
                                valid: (value) {
                                  if (value!.isEmpty) {
                                    return S
                                        .of(context)
                                        .login_email_valid;
                                  }
                                  return null;
                                }),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            child: BuildTextFormField(
                              valid: (value) {
                                if (value!.isEmpty) {
                                  return S
                                      .of(context)
                                      .login_password_valid;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              hintText: S
                                  .of(context)
                                  .login_password,
                              prefixIcon: FontAwesomeIcons.lock,
                              isPassword: !show,
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
                            ),
                          ),

                          SizedBox(
                            height: height * 0.03,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: BuildDropDownButtonField(
                                    cubit: cubit,
                                    height: height,
                                    width: width,
                                    hint: 'Choose Region',
                                    valid: (value) {
                                      if (value == null) {
                                        return 'Please Enter Region';
                                      }
                                    },
                                    item: cubit.regionsModel == null ? [] : cubit
                                        .regionsModel!.data!.regionsList,
                                    num: 1
                                ),
                              ),
                              SizedBox(width: 5,),

                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          cubit.selectCity == false ?
                          BuildDropDownButtonField(
                              cubit: cubit,
                              height: height,
                              width: width,
                              hint: 'Choose University',
                              valid: (value) {
                                if (value == null) {
                                  return 'Please Enter University';
                                }
                              },
                              item: cubit.universitiesModel == null ? [] : cubit
                                  .universitiesModel!.data!.universitiesNames,
                              num: 3
                          ) :
                          cubit.universitiesModel == null ?
                          Container(
                            width: width * 0.45,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: MyColor.primaryColor,
                                ),
                              ],
                            ),
                          ) :
                          BuildDropDownButtonField(
                              cubit: cubit,
                              height: height,
                              width: width,
                              hint: 'Choose University',
                              valid: (value) {
                                if (value == null) {
                                  return 'Please Enter University';
                                }
                              },
                              item: cubit.universitiesModel == null ? [] : cubit
                                  .universitiesModel!.data!.universitiesNames,
                              num: 3
                          ),

                          SizedBox(
                            height: height * 0.03,
                          ),
                          buildButton(
                            width: width,
                            height: height * 0.06,
                            text: S
                                .of(context)
                                .login_sign_up,
                            size: 20,
                            radius: 25,
                            function: () {
                              // TODO Register Function
                              if (formKey.currentState!.validate()) {
                                cubit.postRegister(
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    universityId: cubit.universityId,
                                    name: nameController.text,
                                );
                              }

                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                           BuildText(
                             text:  S
                               .of(context)
                               .login_have_an_account,
                           size: 15,
                           ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()), result: (route) => false);
                                },
                                child: BuildText(
                                  text:       S
                                      .of(context)
                                      .login_Login,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
