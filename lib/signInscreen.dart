import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SinginScreen extends StatefulWidget {
  String previousName;
  static var y;
  SinginScreen({this.previousName});
  @override
  SinginScreenState createState() => SinginScreenState();
}

class SinginScreenState extends State<SinginScreen> {
  GlobalKey fkey;
  static var age;
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text('${widget.previousName} Screeen'),),
      body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.3,
          //   child: Icon(Icons.person, color: Colors.black,)
          //   ),
          Form(
            key: fkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter User Name",
                    contentPadding: EdgeInsets.only(left: 20)
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter email"
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  maxLength: 3,
                  decoration: InputDecoration(
                    hintText: "Age",
                    
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter password"
                  ),
                ),
                

              ],
            ),
          )
        ],)
    );
  }
}