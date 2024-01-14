import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/slide_countdown_clock.dart';
import 'components/slide_direction.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  //DateTime currentBirthDate = DateTime.fromMillisecondsSinceEpoch(1642182000000); // Remplacer cette ligne
  // Nouveau timestamp pour le 14 janvier 2026
  DateTime currentBirthDate = DateTime(2024, 1, 14, 10, 59);
  DateTime deadlineDate = DateTime(2024, 1, 14, 11, 38);
  DateTime nextBirthDate = DateTime(2024, 3, 10, 11, 28);


  bool toogle = false;
  bool showBirthday = false;

  @override
  void initState() {
    super.initState();
    if (currentBirthDate.compareTo(DateTime.now()) < 0) {
      if (deadlineDate.compareTo(DateTime.now()) < 0) {
        letsToggle();
      } else {
        letsBirthdayToggle();
      }
    }
  }

  void letsBirthdayToggle() {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        showBirthday = !showBirthday;
      });
    });
  }

  void letsToggle() {
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        toogle = !toogle;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Duration currentDiff = currentBirthDate.difference(DateTime.now());
    Duration deadlineDiff = deadlineDate.difference(DateTime.now());
    Duration nextDiff = nextBirthDate.difference(DateTime.now());
    if (kDebugMode) {
      print('Current birthDate: $currentBirthDate');
    }
    if (kDebugMode) {
      print('Current date in hours: ${currentDiff.inHours}');
    }
    if (kDebugMode) {
      print('Deadline birthDate: $deadlineDate');
    }
    if (kDebugMode) {
      print('Deadline in hours: ${deadlineDiff.inHours}');
    }
    if (kDebugMode) {
      print('Next birthDate: $nextBirthDate');
    }
    if (kDebugMode) {
      print('Next date in hours: ${nextDiff.inHours}');
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.red.withOpacity(0.3),
              ],
            ),
          ),
          child: showBirthday
              ? Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height / 6),
                  Image.asset(
                    'assets/7.gif',
                    width: width / 3,
                    height: height / 6,
                    gaplessPlayback: false,
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    'assets/2.gif',
                    width: width,
                    height: height / 4,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Agne',
                        color: Color(0xfffce4ec),
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        displayFullTextOnTap: false,
                        pause: const Duration(seconds: 3),
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Happy Birthday RAISSA !!!',
                            speed: const Duration(milliseconds: 60),
                          ),
                          TypewriterAnimatedText(
                            '''I wish you everything You want\'Full of good things to you...''',
                            speed: const Duration(milliseconds: 60),
                          ),

                        ],
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10,
                left: width / 2.5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SlideCountdownClock(
                    duration: deadlineDiff,
                    slideDirection: SlideDirection.Down,
                    separator: " ",
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    shouldShowDays: true,
                    onDone: () {
                      letsToggle();
                    }, decoration: const BoxDecoration(),
                  ),
                ),
              ),
            ],
          )
              : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(width: width / 8),
                  const Text(
                    'Day',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: width / 8),
                  const Text(
                    'Hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: width / 8),
                  const Text(
                    'Mins',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: width / 7),
                  const Text(
                    'Secs',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // current ClockTimer
              Visibility(
                visible: !toogle,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SlideCountdownClock(
                    duration: currentDiff,
                    slideDirection: SlideDirection.Down,
                    separator: " ",
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    shouldShowDays: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.5),
                          blurRadius: 2.0,
                        )
                      ],
                    ),
                    onDone: () {
                      letsBirthdayToggle();
                    },
                  ),
                ),
              ),
              // next ClockTimer
              Visibility(
                visible: toogle,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SlideCountdownClock(
                    duration: nextDiff,
                    slideDirection: SlideDirection.Down,
                    separator: " ",
                    textStyle: TextStyle(
                      fontSize: toogle ? 29 : 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    shouldShowDays: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.5),
                          blurRadius: 2.0,
                        )
                      ],
                    ),
                    onDone: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}