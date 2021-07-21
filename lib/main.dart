import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
class MyHome extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<MyHome> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => MainPage(),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [Expanded(
          child:Material(

                child: Container(
                  color: bg,
                  child: Align(alignment: Alignment.center,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'TIC TAC TOE',
                          textStyle: const TextStyle(
                            fontFamily: "Monsterrrat",
                            color: Vx.white,
                            backgroundColor: bg,
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                          ),
                          speed: const Duration(milliseconds: 300),
                        ),
                      ],
                      pause: const Duration(milliseconds: 500),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
          ),
                ),




          ))]);
  }
}



