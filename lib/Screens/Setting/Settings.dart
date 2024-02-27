import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/Text/text.dart';
import '../../generated/l10n.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

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
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width*0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildText(
              text: S.of(context).settings_logo,
              color: MyColor.primaryColor,
              size: 25,
              bold: true,
            ),
            Row(
              children: [
                BuildText(
                  text: S.of(context).settings_title_language,
                  size: 14,
                  bold: true,
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      cubit.changeLanguageApp();
                    },
                    child: BuildText(text: S.of(context).setting_button,bold: true,),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                BuildText(
                  text: 'The Application Language is English',
                  size: 14,
                  bold: true,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: BuildText(text: 'Change',bold: true,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);
  }
}

