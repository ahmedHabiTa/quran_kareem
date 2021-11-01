import 'package:flutter/material.dart';
import 'package:quran_kareem/presentation/screens/children_screen.dart';
import 'package:quran_kareem/presentation/screens/quran_player_screen.dart';
import 'package:quran_kareem/presentation/screens/options_screen.dart';
import 'package:quran_kareem/presentation/widgets/custom_card.dart';

import '../../notifications.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> pages = [
    OptionsScreen(),
    QuranPlayerScreen(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceivedNotification notification) {
    print('notification received');
  }

  onNotificationClick(String payload) {
    print('payload $payload');
  }

  @override
  Widget build(BuildContext context) {
    // DateTime dateTime = DateTime.now();
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            print('No Exit');
            return;
            // final difference = DateTime.now().difference(dateTime);
            // final isExitWarning = difference >= Duration(seconds: 2);
            // dateTime = DateTime.now();
            // if (isExitWarning) {
            //   Fluttertoast.showToast(
            //       msg: "اضغط مره اخره للخروج من التطبيق",
            //       toastLength: Toast.LENGTH_SHORT,
            //       gravity: ToastGravity.BOTTOM,
            //       timeInSecForIosWeb: 1,
            //       backgroundColor: Colors.white,
            //       textColor: Colors.black87,
            //       fontSize: 16.0);
            //   return false;
            // } else {
            //   return true;
            // }
          },
          child: IndexedStack(
            children: pages,
            index: selectedIndex,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              selectedIndex == 0 ? Colors.blue[900] : Colors.black38,
          elevation: 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[600],
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسيه',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_voice),
              label: 'الاستماع',
            ),
          ],
        ),
      ),
    );
  }
}
