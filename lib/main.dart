import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';
import 'display.dart';
import 'Screens/Login/index.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void loginF(BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => new LoginScreen()));
  }
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;
    
    return Scaffold(
      backgroundColor: Color(0xFF8185E2),
          body: Container(
      
          child: Center(
            child: Column(
                children: <Widget>[
                  AvatarGlow(
                    endRadius: 90,
                    duration: Duration(seconds: 2),
                    glowColor: Colors.white24,
                    repeat: true,
                    repeatPauseDuration: Duration(seconds: 2),
                    startDelay: Duration(seconds: 1),
                    child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: FlutterLogo(
                            size: 50.0,
                          ),
                          radius: 50.0,
                        )),
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Smart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: color),
                    ),
                    delay: delayedAmount + 1000,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "Budgeting",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0,
                          color: color),
                    ),
                    delay: delayedAmount + 2000,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DelayedAnimation(
                    child: Text(
                      "A plan to spend your Money ",
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    delay: delayedAmount + 3000,
                  ),
                  // DelayedAnimation(
                  //   child: Text(
                  //     "Journaling  companion",
                  //     style: TextStyle(fontSize: 20.0, color: color),
                  //   ),
                  //   delay: delayedAmount + 3000,
                  // ),
                  SizedBox(
                    height: 100.0,
                  ),
                  DelayedAnimation(
                  child: GestureDetector(
                    onTap: (){
                      this.loginF(context);

                    },

                    child: Transform.scale(
                      scale: _scale,
                      child: _animatedButtonUI,
                    ),
                  ),
                  delay: delayedAmount + 4000,
                ),
                SizedBox(height: 50.0,),
                  DelayedAnimation(
                    child: Text(
                      "I Already have An Account".toUpperCase(),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: color),
                    ),
                    delay: delayedAmount + 5000,
                  ),
                ],
              ),
            ),
          ),
          );
  }
 
  Widget get _animatedButtonUI => Container(
        height: 60,
        width: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        child:Center(
         
              child: 
            Text(
              'Continue >>>',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8185E2),
              ),
            ),
          
        ),
      );

//   void _onTapDown(TapDownDetails details) {
     
//            Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => LoginScreen()),
//   );
//   }

//   void _onTapUp(TapUpDetails details) {
//     _controller.reverse();
//   }
}
 

