import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_kareem/presentation/screens/ayat_screen.dart';
import 'package:quran_kareem/presentation/screens/city_category_screen.dart';
import 'package:quran_kareem/presentation/screens/daily_routine.dart';
import 'package:quran_kareem/presentation/screens/first_screen.dart';
import 'package:quran_kareem/presentation/screens/home_screen.dart';
import 'package:quran_kareem/presentation/screens/praying_time_table.dart';
import 'package:quran_kareem/presentation/screens/quran_player_screen.dart';
import 'package:quran_kareem/presentation/screens/reader_screen.dart';
import 'package:quran_kareem/presentation/screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox<String>('myBox');
  Box box = Hive.box<String>('myBox');
  if (box.get('playedOnce') == null) {
    box.put(
      'playedOnce',
      'false',
    );
  }
  runApp(MyApp());
}

final getIt = GetIt.instance;

class AudioManager {
  AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audio => _audioPlayer;
}

void setUp() {
  getIt.registerFactory(() => AudioManager());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 20,
            backgroundColor: Colors.black54,
            splashColor: Colors.deepOrange,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[900],
            elevation: 0,
          ),
          canvasColor: Colors.blue[900]),
      debugShowCheckedModeBanner: false,
      title: 'Qur\'an kareem',
      home: SplashScreen(),
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        MusicPlayerScreen.routeName: (context) => MusicPlayerScreen(),
        FirstScreen.routeName: (context) => FirstScreen(),
        DailyRoutine.routeName: (context) => DailyRoutine(),
        PrayTimes.routeName: (context) => PrayTimes(),
        CityCategoryScreen.routeName: (context) => CityCategoryScreen(),
        ReaderScreen.routeName: (context) => ReaderScreen(),
        AyatScreen.routeName: (context) => AyatScreen(),
      },
    );
  }
}
