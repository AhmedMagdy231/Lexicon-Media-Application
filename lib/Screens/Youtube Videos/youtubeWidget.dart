
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeBuilder extends StatefulWidget {
  final videoUrl;
  const YoutubeBuilder({Key? key,required this.videoUrl}) : super(key: key);

  @override
  _YoutubeBuilderState createState() => _YoutubeBuilderState();
}



class _YoutubeBuilderState extends State<YoutubeBuilder> {


  late YoutubePlayerController  _controller;

  @override
  initState() {
    super.initState();
    final VideoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: VideoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,

      ),


    );

  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(
          isExpanded: true,
          colors: ProgressBarColors(
            playedColor: MyColor.primaryColor,
            handleColor: MyColor.primaryColor,
          ),

        ),
        const PlaybackSpeedButton(),
        RemainingDuration(),
        FullScreenButton(),


      ],
    );
  }
}
