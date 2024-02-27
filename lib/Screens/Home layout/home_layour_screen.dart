import 'package:animate_do/animate_do.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Network/Local/CashHelper.dart';
import 'package:education_application/Screens/BookMarks/bookmarks_screen.dart';
import 'package:education_application/Screens/Search%20Screen/search_screen.dart';
import 'package:education_application/Screens/Threads/threads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../Cubits/Local Database Cubit/database_cubit.dart';
import '../../generated/l10n.dart';
import '../Drawer/drawer.dart';
import '../Login/login_screen.dart';
import '../Notfication/notfication_screen.dart';
import 'package:badges/badges.dart' as badges;

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          key: cubit.scaffoldKey,
          drawer: buildDrawer(width, height, cubit, context),
          appBar: AppBar(
            title: BuildText(
              text: S.of(context).settings_logo,
              color: Colors.white,
              bold: true,
            ),
            backgroundColor: MyColor.primaryColor,
            actions: [

              GestureDetector(
                onTap: (){
                  cubit.searchController.clear();
                  cubit.searchModel = null;
                  navigateTo(context, SearchScreen());
                },
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 32,
                  color: Colors.white,
                  //semanticsLabel: 'A red up arrow'
                ),
              ),

              SizedBox(
                width: width * 0.04,
              ),

             CashHelper.getData(key: 'login') == null
                  ? GestureDetector(
                      onTap: () {
                        cubit.getNotification(page: 1);
                        navigateTo(context, NotificationScreen());
                      },
                      child: SvgPicture.asset(
                        'assets/icons/notification.svg',
                        width: 30,
                        color: Colors.white,
                        //semanticsLabel: 'A red up arrow'
                      ),
                    )
                  : cubit.userModel == null || cubit.userModel!.data!.newstudentsNotifications! == "0"?
             GestureDetector(
               onTap: () {
                 cubit.getNotification(page: 1);
                 navigateTo(context, NotificationScreen());
               },
               child: SvgPicture.asset(
                 'assets/icons/notification.svg',
                 width: 30,
                 color: Colors.white,
                 //semanticsLabel: 'A red up arrow'
               ),
             )
                 :
             badges.Badge(
                      position: badges.BadgePosition.topEnd(top: -height*0.01, end: width*0.045),
                      badgeContent:
                      BuildText(
                        text: cubit.userModel == null
                            ? ''
                            : cubit.userModel!.data!.newstudentsNotifications!,
                        color: Colors.white,
                        size: 12,
                        bold: true,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          cubit.getNotification(page: 1);
                          navigateTo(context, NotificationScreen());
                        },
                        child: SvgPicture.asset(
                          'assets/icons/notification.svg',
                          width: 30,
                          color: Colors.white,
                          //semanticsLabel: 'A red up arrow'
                        ),
                      ),
                    ),
              SizedBox(
                width: width * 0.04,
              ),


              CashHelper.getData(key: 'login') == null
                  ? GestureDetector(
                onTap: () {
                  cubit.postThreads();
                  navigateTo(
                      context,
                      ThreadsScreen(
                        context: context,
                      ));
                },
                child: SvgPicture.asset(
                  'assets/icons/chat.svg',
                  width: 30,
                  color: Colors.white,
                  //semanticsLabel: 'A red up arrow'
                ),
              )
                  : cubit.userModel == null || cubit.userModel!.data!.new_threadstud_unread == "0"?
              GestureDetector(
                onTap: () {
                  cubit.postThreads();
                  navigateTo(
                      context,
                      ThreadsScreen(
                        context: context,
                      ));
                },
                child: SvgPicture.asset(
                  'assets/icons/chat.svg',
                  width: 30,
                  color: Colors.white,
                  //semanticsLabel: 'A red up arrow'
                ),
              )
                  :
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: -height*0.01, end: width*0.045),
                badgeContent:
                BuildText(
                  text: cubit.userModel == null
                      ? ''
                      : '${cubit.userModel!.data!.new_threadstud_unread}',
                  color: Colors.white,
                  size: 12,
                  bold: true,
                ),
                child: GestureDetector(
                  onTap: () {
                    cubit.postThreads();
                    navigateTo(
                        context,
                        ThreadsScreen(
                          context: context,
                        ));
                  },
                  child: SvgPicture.asset(
                    'assets/icons/chat.svg',
                    width: 30,
                    color: Colors.white,
                    //semanticsLabel: 'A red up arrow'
                  ),
                ),
              ),


              SizedBox(
                width: width * 0.03,
              ),
            ],
          ),
          body: cubit.myScreens[cubit.indexScreen],
          bottomNavigationBar: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.01),
              child: GNav(
                selectedIndex: cubit.indexScreen,
                backgroundColor: Colors.white,
                // tab button hover color
                haptic: true,
                // haptic feedback
                tabBorderRadius: 10,
                // tab animation curves
                duration: const Duration(milliseconds: 400),
                // tab animation duration
                gap: width * 0.03,
                // the tab button gap between icon and text
                color: Colors.grey[700],
                // unselected icon color
                activeColor: MyColor.primaryColor,
                // selected icon and text color
                textStyle: GoogleFonts.notoSansArabic(
                  fontWeight: FontWeight.bold,
                  color: MyColor.primaryColor,
                ),
                iconSize: 24,
                // tab button icon size
                tabBackgroundColor: Colors.purple.withOpacity(0.2),
                // selected tab background color
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * 0.015),
                // navigation bar padding
                tabs: const [
                  GButton(
                    icon: FontAwesomeIcons.home,
                    text: 'الرئيسة',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.book,
                    text: 'الأقسام',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.tasks,
                    text: 'ملاحظات',
                  ),
                  GButton(
                    icon: FontAwesomeIcons.user,
                    text: 'حسابي',
                  ),
                  // GButton(
                  //  icon: Icons.settings,
                  //   text: 'Setting',
                  //   iconSize: 25,
                  // )
                ],
                onTabChange: (index) {
                  if (index == 2) {
                    DatabaseCubit.get(context).filterNotes =
                        DatabaseCubit.get(context).allnotes;
                  }
                  cubit.changeIndexScreen(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
