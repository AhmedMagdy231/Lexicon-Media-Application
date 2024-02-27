import 'package:education_application/Components/components.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Constant/Colors/colors.dart';
import '../../Models/Page Details/page_details.dart';

class ZoomImage extends StatefulWidget {
  final List<PagesPosts> images;
  late int index;

   ZoomImage({Key? key,required this.images,required this.index}) : super(key: key);

  @override
  State<ZoomImage> createState() => _ZoomImageState();

}

class _ZoomImageState extends State<ZoomImage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boardController = PageController(initialPage: widget.index);
  }
  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: height*0.05),
      child: Stack(
        children: [
          PageView.builder(
             itemBuilder: (context,ind){
               return Center(
                 child: InteractiveViewer(
                   clipBehavior: Clip.none,
                   minScale: 1,
                   child: AspectRatio(
                     aspectRatio: 1,
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(0),
                       child:  SizedBox(
                         height: height*0.5,
                         child: buildImage(image: widget.images[widget.index].pagespostFilename,fit: 'cover'),
                       ),
                     ),
                   ),
                 ),
               );
             },
            itemCount: widget.images.length,
            onPageChanged: (value){
               print(value);
               setState(() {

                if(value != widget.images.length){
                   widget.index = value;
                 }


               });
            },
            controller: boardController,

          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: widget.images.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: MyColor.primaryColor,
                    dotHeight: 5,
                    dotWidth: 5,
                    spacing: 5,
                    expansionFactor: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
