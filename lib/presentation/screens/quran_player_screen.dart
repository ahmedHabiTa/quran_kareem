import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:quran_kareem/presentation/widgets/background_container.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_quran_player_item.dart';
import '../../main.dart';

import '../../data/quran_data.dart';
import 'first_screen.dart';
import 'home_screen.dart';

class MusicPlayerScreen extends StatefulWidget {
  static const routeName = 'MusicPlayerScreen';

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with WidgetsBindingObserver {
  Duration duration;

  Duration position;

  bool isPlaying = false;
  bool isRepeat = false;

  AudioManager audioManager;

  AudioPlayer audioPlayer;
  IconData btmIcon = Icons.play_arrow;

  Box box = Hive.box<String>('myBox');

  // String currentSong = '';
  String currentTitle = '';
  String musicUrl = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    audioManager = getIt<AudioManager>();
    audioPlayer = audioManager.audio;
    duration = Duration();
    position = Duration();
    if (box.get('playedOnce') == 'false') {
      setState(() {
        currentTitle = 'اختر سوره لتستمع اليها';
      });
    } else if (box.get('playedOnce') == 'true') {
      currentTitle = box.get('currentTitle');
      musicUrl = box.get('url');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      setState(() {
        btmIcon = Icons.pause;
        audioPlayer.onDurationChanged.listen((event) {
          setState(() {
            duration = event;
          });
        });
        audioPlayer.onAudioPositionChanged.listen((event) {
          setState(() {
            position = event;
          });
        });
      });
    } else if (state == AppLifecycleState.resumed) {
      if (isPlaying == true) {
        audioPlayer.resume();
        setState(() {
          audioPlayer.onDurationChanged.listen((event) {
            setState(() {
              duration = event;
            });
          });
          audioPlayer.onAudioPositionChanged.listen((event) {
            setState(() {
              position = event;
            });
          });
        });
      }
    } else if (state == AppLifecycleState.detached) {
      audioPlayer.stop();
      audioPlayer.release();
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   print('+++++++++++++dispose');
  // }

  void playMusic(String url) async {
    if (isPlaying) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          musicUrl = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
          btmIcon = Icons.pause;
        });
      }
    }
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        position = Duration(seconds: 0);
        isPlaying = false;
      });
    });
  }

  void moveToSecond(int second) {
    Duration duration = Duration(seconds: second);
    audioPlayer.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    QuranData quranData = QuranData();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BackgroundContainer(
              widget: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: deviceWidth < 370 ? 20 : 30,
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              HomeScreen.routeName,
                            );
                          },
                          icon:const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: deviceWidth * 0.8,
                          child: customAnimatedText(
                              fontSize: deviceWidth * 0.05,
                              height: deviceHeight * 0.05,
                              width: deviceWidth,
                              text: 'صوت القارئ : ياسين الجزائري',
                              context: context),
                        ),
                        Spacer(),
                      ],
                    ),
                   const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                        const  Icon(
                            Icons.queue_music_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            ' قائمه السور',
                            style: GoogleFonts.alice(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: deviceWidth < 370 ? 15 : 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: deviceHeight * 0.6,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return customQuranPlayerItem(
                            context: context,
                            title: quranData.list[index]['title'],
                            onTap: () async {
                              setState(() {
                                currentTitle = quranData.list[index]['title'];
                                musicUrl = quranData.list[index]['url'];
                                // currentSong = url ;
                              });
                              playMusic(musicUrl);
                              box.put('playedOnce', 'true');
                              box.put('currentTitle', currentTitle);
                              box.put('url', musicUrl);
                            },
                          );
                        },
                        itemCount: quranData.list.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              // right: deviceWidth * 0.07,
              // left: deviceWidth * 0.07,
              child: Container(
                width: deviceWidth,
                height: deviceWidth < 370
                    ? deviceHeight * 0.25
                    : deviceHeight * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue[900],
                      Colors.black54,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${'$currentTitle'}',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Slider.adaptive(
                        // onChangeEnd: (value){
                        //   audioPlayer.;
                        // },
                        activeColor: Colors.orange,
                        inactiveColor: Colors.deepPurple[200],
                        value: position.inSeconds.toDouble(),
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          moveToSecond(value.toInt());
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            position.inSeconds.toDouble().toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            duration.inSeconds.toDouble().toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: IconButton(
                              icon: Icon(
                                isRepeat == false
                                    ? Icons.repeat
                                    : Icons.repeat_one,
                                size: deviceWidth < 370 ? 20 : 25,
                                color: isRepeat == false
                                    ? Colors.white
                                    : Colors.orange,
                              ),
                              onPressed: () {
                                if (isRepeat == false) {
                                  audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                                  setState(() {
                                    isRepeat = true;
                                  });
                                } else {
                                  setState(() {
                                    audioPlayer
                                        .setReleaseMode(ReleaseMode.STOP);
                                    isRepeat = false;
                                  });
                                }
                              }),
                        ),
                        // customBottom(),
                        IconButton(
                          icon: Icon(
                            btmIcon,
                            size: deviceWidth < 370 ? 30 : 40,
                            color: Colors.orange,
                          ),
                          onPressed: musicUrl == ''
                              ? () {
                                  Fluttertoast.showToast(
                                      msg: "من فضلك اختر سوره لتستمع اليها",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              : () {
                                  if (box.get('playedOnce') == 'true' &&
                                      isPlaying == false) {
                                    playMusic(musicUrl);
                                  } else {
                                    if (isPlaying) {
                                      audioPlayer.pause();
                                      setState(() {
                                        btmIcon = Icons.play_arrow;
                                        isPlaying = false;
                                      });
                                    } else {
                                      audioPlayer.resume();
                                      setState(() {
                                        btmIcon = Icons.pause;
                                        isPlaying = true;
                                      });
                                    }
                                  }
                                },
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
  }
}
