import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Cubits/Auth%20Cubit/auth_cubit.dart';
import 'package:education_application/Network/Local/CashHelper.dart';
import 'package:education_application/Screens/Forget%20Password/forget_password.dart';
import 'package:education_application/Screens/Home%20layout/home_layour_screen.dart';
import 'package:education_application/Screens/Register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../Components/TextField/text_form_field.dart';
import '../../Components/components.dart';
import '../../Constant/Varibles/variables.dart';
import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool show = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return buildGlobOverLay(
      widget: BlocConsumer<AuthCubit, AuthState>(
     listener: (context, state) async {
      // TODO: implement listener
       if(state is LoginLoading){
         context.loaderOverlay.show(widget: buildOverlayLoading(height));
       }
       if(state is LoginSuccess){

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
          await CashHelper.putData(key: 'token', value: state.token);
        //  kToken = await CashHelper.getData(key: 'token');
          CashHelper.putData(key: 'login', value: true);
           AppCubit.get(context).postUserData(token: state.token);
          Navigator.pop(context);
          // navigateToToFinish(context, HomeLayout());
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
      var cubit = AuthCubit.get(context);
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
                  height: height * 0.4,
                  decoration: BoxDecoration(
                      color: MyColor.primaryColor,
                      image: const DecorationImage(
                          image: AssetImage('assets/images/login.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          S.of(context).login_Login,
                          style: GoogleFonts.openSans(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
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
                                blurRadius: 30,
                                spreadRadius: 1,
                                offset: Offset(0, 0)),
                          ],
                        ),
                        child: BuildTextFormField(
                            controller: emailController,
                            hintText: S.of(context).login_email,
                            prefixIcon: FontAwesomeIcons.envelope,
                            valid: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).login_email_valid;
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
                              return S.of(context).login_password_valid;
                            }
                            return null;
                          },
                          controller: passwordController,
                          hintText: S.of(context).login_password,
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
                      TextButton(
                        onPressed: () {
                          navigateTo(context, ForgetPasswordScreen());
                        },
                        child: Text(
                            S.of(context).login_forget_password,
                          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                        ),

                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                   state is LoginLoading ? Center(
                     child: CircularProgressIndicator(
                       color: MyColor.primaryColor,
                     ),
                   ) : buildButton(
                        width: width,
                        height: height * 0.06,
                        text: S.of(context).login_Login,
                        size: 20,
                        radius: 25,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.postLogin(email: emailController.text, password: passwordController.text);
                          }

                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).login_have_an_account,
                            style: GoogleFonts.lato(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()), result: (route) => false);

                            },
                            child: Text(
                              S.of(context).login_sign_up,
                              style: GoogleFonts.lato(
                                fontSize: 16,
                                color: MyColor.primaryColor,
                                fontWeight: FontWeight.bold,
                             ),
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
