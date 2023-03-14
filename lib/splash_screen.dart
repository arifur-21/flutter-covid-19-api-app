
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

 late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
      vsync: this)..repeat();

 @override
  void initState() {
    Timer(Duration(seconds: 5), ()=> Get.to(HomeScreen())
    );
    super.initState();
  }
  @override
  void dispose() {
   _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image(image: AssetImage('assets/images/covid.jpg'),),
                  ),
                ),
                builder: (BuildContext context, Widget? child){

                  return Transform.rotate(
                      angle: _controller.value * 3.0 * math.pi,
                    child: child,
                  );
            }
            ),

            SizedBox(height: 50,),

            Align(
              alignment: Alignment.center,
              child: Text("Covid-19", textAlign: TextAlign.center, style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    );
  }
}
