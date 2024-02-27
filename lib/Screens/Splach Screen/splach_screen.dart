import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Components/components.dart';
import 'package:education_application/Screens/Home%20layout/home_layour_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  final FirstScreen;
  const SplashScreen({Key? key,required this.FirstScreen}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with SingleTickerProviderStateMixin{

  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.bounceInOut,
    );

    _animationController!.addListener(() {
      if(_animationController!.isCompleted){
         navigateToToFinish(context, widget.FirstScreen);
      }
    });

    _animationController!.forward();

  }

  @override
  void dispose() {
    _animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (context,child){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/app_logo.png',
                  width: _animation!.value*width*0.7,
                  height: _animation!.value*width*0.7,
                ),

                 BuildText(
                     text: "المعجم الإعلامي",
                 size: 24,
                 color: Colors.grey,
                 ),

              ],
            );
          },
        ),
      ),
    );
  }
}
