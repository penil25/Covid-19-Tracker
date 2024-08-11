import 'dart:async';
import 'package:covid_tracker/View/worldstate_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> WorldStateScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [

            AnimatedBuilder(
                animation: animationController,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image(image: AssetImage('images/virus.png'),),
                  ),
                ),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                      angle: animationController.value * 2.0 * math.pi,
                      child: child,
                  );
                }
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .08,),
            Align(
              alignment: Alignment.center,
              child: Text('Covid-19\nTracker App',textAlign: TextAlign.center, style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),),
            )

          ],
        ),
      ),
    );
  }
}
