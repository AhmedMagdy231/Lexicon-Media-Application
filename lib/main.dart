import 'dart:ffi';

import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Cubits/App%20Cubit/app_cubit.dart';
import 'package:education_application/Cubits/Auth%20Cubit/auth_cubit.dart';
import 'package:education_application/Cubits/Local%20Database%20Cubit/database_cubit.dart';
import 'package:education_application/Network/Local/CashHelper.dart';
import 'package:education_application/Network/Local/Database/database.dart';
import 'package:education_application/Network/Remote/dio_helper.dart';
import 'package:education_application/Screens/Categories/categories_screen.dart';
import 'package:education_application/Screens/Forget%20Password/forget_password.dart';
import 'package:education_application/Screens/Home%20layout/home_layour_screen.dart';
import 'package:education_application/Screens/Home/home_screen.dart';
import 'package:education_application/Screens/Intorduction/introduction_screen.dart';
import 'package:education_application/Screens/Images/show_imag.dart';
import 'package:education_application/Screens/Splach%20Screen/splach_screen.dart';
import 'package:education_application/test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Constant/Varibles/variables.dart';
import 'Cubits/bloc_observer.dart';

import 'generated/l10n.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await Future.wait([CashHelper.init(),MyDatabase.initliazeDatabase()]);

  print(CashHelper.getData(key: 'token'));
  //downloadFile();

  var rootWidget = await checkFirstTime();


  runApp(MyApp(widget: rootWidget,));
}

Future<void> downloadFile() async {
  final status = await Permission.storage.request();
  if(await status.isGranted){

    var baseStorage = await getExternalStorageDirectory();
    final id = FlutterDownloader.enqueue(
        url: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
        savedDir: baseStorage!.path,
        fileName: 'filenam.mp4',
        showNotification: true,
    );
  }
  else
    {
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      print(status);
      print('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    }
}

Widget checkFirstTime(){

 print(CashHelper.getData(key: 'firstTime'));
  if(CashHelper.getData(key: 'firstTime') != true) {
    return IntroductionScreen();
  }
  else
  {
       return HomeLayout();
  }


}


class MyApp extends StatelessWidget {

  final widget;
    MyApp({required this.widget});

  @override
  Widget build(BuildContext context) {
    // var cubit = AppCubit.get(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getHomeData()
              ..getCategory()
              ..postUserData(
                token: CashHelper.getData(key: 'token'),
              ),
        ),
        BlocProvider(create: (context) => AuthCubit()..getRegionData()..postGetUniversities()),
        BlocProvider(create: (context)=>DatabaseCubit()..getAllNotes()),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            //AppCubit.get(context).language
            locale: Locale(AppCubit.get(context).language),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Media Lexicon',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                foregroundColor: Colors.white,

                surfaceTintColor: Colors.white,
                elevation: 0,
                  color: MyColor.primaryColor,
                  iconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  titleTextStyle: const TextStyle(color: Colors.white)
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: MyColor.primaryColor),
              useMaterial3: true,
            ),

            home: SplashScreen(FirstScreen: widget,),
          );
        },
      ),
    );
  }
}
