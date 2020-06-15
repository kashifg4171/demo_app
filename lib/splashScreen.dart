import 'package:demo/signInscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String name = "Assad Mumtaz";
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SinginScreen(previousName: name,),));
    });
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(500, 560), topRight: Radius.elliptical(5, 160), bottomLeft: Radius.elliptical(0, 160)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  //width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.yellow,
                )
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(500, 560), topRight: Radius.elliptical(5, 160), bottomLeft: Radius.elliptical(0, 160)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.blue,
                )
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(500, 560), topRight: Radius.elliptical(5, 160), bottomLeft: Radius.elliptical(0, 160)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    // borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(100, 160), topRight: Radius.elliptical(5, 160), bottomLeft: Radius.elliptical(0, 160)),
                  ),
                  child: Image.asset('assets/images/burger.png', fit: BoxFit.cover,),
                )
              ),
            ],),
          ),
          Container(
            height: MediaQuery.of(context).size.height* 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              CircleAvatar(backgroundImage: AssetImage('assets/images/parath3.png')),
              SizedBox(width: 10,),
              Text('Dart', textAlign: TextAlign.right, style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w700, fontSize: 21, shadows: [
                Shadow(blurRadius: 2, color: Colors.black, offset: Offset(2,2))
              ]),)
            ],),
          ),
          Container(
            child: Center(
              child: Text('Let\'s Test test test test test'),
            ),
          )
      ],),
    );
  }
}