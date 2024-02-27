import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';

class ShowVideoScreen extends StatefulWidget {
  final url;
  const ShowVideoScreen({Key? key,required this.url}) : super(key: key);

  @override
  State<ShowVideoScreen> createState() => _ShowVideoScreenState();
}

class _ShowVideoScreenState extends State<ShowVideoScreen> {
  late CustomVideoPlayerController  _customVideoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeVideoPlayer();
  }

  void initializeVideoPlayer(){
    VideoPlayerController  _videoPlayerController;
    _videoPlayerController = VideoPlayerController.network(widget.url)..initialize().then((value){
      setState(() {});
    });

    _customVideoPlayerController = CustomVideoPlayerController(
        context: context,
        videoPlayerController: _videoPlayerController
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _customVideoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: width,
        height: height*0.95,
        child: CustomVideoPlayer(
          customVideoPlayerController: _customVideoPlayerController,
        ),
      ),
    );
  }
}
