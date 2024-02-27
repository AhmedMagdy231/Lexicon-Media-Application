
import 'package:education_application/Screens/Youtube%20Videos/youtubeWidget.dart';
import 'package:flutter/material.dart';

class ShowYoutubeVideoScreen extends StatelessWidget {
  final url;
   ShowYoutubeVideoScreen({Key? key,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: YoutubeBuilder(videoUrl: url),
            ),
          ],
        ),
      ),
    );
  }
}
