import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:quran_kareem/network/local/shared_pref_helper.dart';
import 'package:quran_kareem/presentation/widgets/custom_animated_text.dart';
import 'package:quran_kareem/presentation/widgets/custom_quran_player_item.dart';
import '../../main.dart';
import '../../data/quran_data.dart';

class QuranPlayerScreen extends StatefulWidget {
  static const routeName = 'MusicPlayerScreen';

  @override
  _QuranPlayerScreenState createState() => _QuranPlayerScreenState();
}

class _QuranPlayerScreenState extends State<QuranPlayerScreen>
    with WidgetsBindingObserver {
  Duration duration;

  Duration position;

  bool isPlaying = false;
  bool isRepeat = false;

  AudioManager audioManager;

  AudioPlayer audioPlayer;
  IconData btmIcon = Icons.play_arrow;

  Box box = Hive.box<String>('myBox');

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

  void playMusic({
    QuranData quranData,
    int index,
  }) async {
   if(index == null){
     index = SharedPrefsHelper.getData(key: 'index');
   }
    if (isPlaying) {
      audioPlayer.pause();
      int result = await audioPlayer.play(quranData.list[index]['url']);
      if (result == 1) {
        setState(() {
          musicUrl = quranData.list[index]['url'];
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(quranData.list[index]['url']);
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
      index = index + 1;
      if (index < quranData.list.length) {
        setState(() {
         currentTitle = quranData.list[index]['title'];
          isPlaying = true;
          btmIcon = Icons.pause;
        });
        audioPlayer.play(quranData.list[index]['url']);
        print('---------$index');
      } else {
        setState(() {
          position = Duration(seconds: 0);
          duration = Duration(seconds: 0);
          isPlaying = false;
          btmIcon = Icons.play_arrow;
        });
        print('finished');
      }

    });
  }

  void moveToSecond(int second) {
    Duration duration = Duration(seconds: second);
    audioPlayer.seek(duration);
  }

  // void autoPlay({
  //   int index,
  //   int currentSurahIndex,
  //   QuranData quranData,
  // }) async {
  //   if (index > 113) {
  //     await audioPlayer.stop();
  //     await audioPlayer.release();
  //   } else {
  //     await audioPlayer.play(quranData.list[currentSurahIndex]['title']);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    QuranData quranData = QuranData();

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: deviceHeight,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      width: deviceWidth * 0.8,
                      child: customAnimatedText(
                          fontSize: deviceWidth * 0.05,
                          height: deviceHeight * 0.05,
                          width: deviceWidth,
                          text: 'صوت القارئ : ياسين الجزائري',
                          context: context),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
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
                    height: deviceHeight * 0.53,
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
                            });
                            playMusic(quranData: quranData, index: index);
                            box.put('playedOnce', 'true');
                            box.put('currentTitle', currentTitle);
                            box.put('url', musicUrl);
                            await SharedPrefsHelper.saveData(
                                key: 'index', value: index);
                          },
                        );
                      },
                      itemCount: quranData.list.length,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: deviceWidth,
                height: deviceWidth < 370
                    ? deviceHeight * 0.2
                    : deviceHeight * 0.17,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35)),
                    color: Colors.black38),
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
                      height: 20,
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
                          child: _buildPositionTime(),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: _buildDurationTime(),
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
                                    playMusic(quranData: quranData);
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

  Widget _buildPositionTime() {
    String twoDigits(int number) => number.toString().padLeft(2, '0');
    final hours = twoDigits(position.inHours.remainder(60));
    final minutes = twoDigits(position.inMinutes.remainder(60));
    final seconds = twoDigits(position.inSeconds.remainder(60));
    return Text(
      '$hours:$minutes:$seconds',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildDurationTime() {
    String twoDigits(int number) => number.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      '$hours:$minutes:$seconds',
      style: TextStyle(color: Colors.white),
    );
  }
}
