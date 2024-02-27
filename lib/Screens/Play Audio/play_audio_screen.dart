import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:education_application/Components/Text/text.dart';
import 'package:education_application/Constant/Colors/colors.dart';
import 'package:education_application/Models/Page%20Details/page_details.dart';
import 'package:flutter/material.dart';

class PlayAudioScreen extends StatefulWidget {
  late String url;
  late String name;
   PlayAudioScreen({required this.url,required this.name});

  @override
  State<PlayAudioScreen> createState() => _PlayAudioScreenState();
}

class _PlayAudioScreenState extends State<PlayAudioScreen> {

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    // TODO: implement dispose

    audioPlayer.stop();
    audioPlayer.dispose();

    super.dispose();
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.play(UrlSource(widget.url));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyColor.primaryColor,
            Colors.black,
          ],
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.08,
              ),
              Container(
                height: height * 0.35,
                width: width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: widget.url,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/audio.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.14,
              ),
              BuildText(

                text: widget.name,
                color: Colors.white,
                bold: true,
                size: 25,
                center: true,
                maxLines: 1,
                overflow: true,
              ),
              Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final postion = Duration(seconds: value.toInt());
                  await audioPlayer.seek(postion);

                  await audioPlayer.resume();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildText(
                    text: formatTime(position),
                    color: Colors.white,
                  ),
                  BuildText(
                    text: formatTime(duration - position),
                    color: Colors.white,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.forward,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      audioPlayer.seek(Duration(seconds: position.inSeconds -5 ));
                    },
                  ),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 50,
                        color: MyColor.primaryColor,
                      ),
                      onPressed: () async {
                        if (isPlaying) {
                          await audioPlayer.pause();
                        } else {
                          await audioPlayer.resume();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.backward,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      audioPlayer.seek(Duration(seconds: position.inSeconds + 5));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}
