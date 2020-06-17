import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SinginScreen extends StatefulWidget {
  String previousName;
  static var y;
  SinginScreen({this.previousName});
  @override
  SinginScreenState createState() => SinginScreenState();
}

class SinginScreenState extends State<SinginScreen> {
  final fkey=GlobalKey<FormState>();
  static var age;
  final userName=TextEditingController();
  final email=TextEditingController();
  final ageController=TextEditingController();
  final passwordController=TextEditingController();

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text('${widget.previousName} Screeen'),),
      body:
        SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              
              
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
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
                        controller: userName,
                        validator: (input){
                          if(input.length < 3){
                            return "Username is too short.";
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: "Enter User Name",
                          contentPadding: EdgeInsets.only(left: 20)
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: email,
                        validator: (input){
                          return validateEmail(input);
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter email"
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller: ageController,
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
                        controller: passwordController,
                        validator: (input){
                          return input.length<8?"Password must be greater than 7 charaters":null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Enter password"
                        ),
                      ),
                      
                      Container(
                        child: _image==null?Icon(Icons.add_a_photo):Image.file(_image),
                      ),
                      Container(
                        child: CachedNetworkImage(
                            imageUrl: "https://www.comsats.edu.pk/img/25.jpg",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter:
                                        ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                              ),
                            ),
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      RaisedButton(
                        onPressed: (){
                          // picker.getImage(source: ImageSource.camera).then((value) {
                          //   _image=File(value.path);
                          // });
                          getImage();
                        },
                        child: Text('Pick Profile Image'),
                      )
                      
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                    print('''
                    User Name: ${userName.text}, 
                    Email : ${email.text}
                    ''');

                    // FormState fs=fkey.currentState;
                    if(userName.text.isNotEmpty){
                      print('My form is valid');
                    }else{
                      print('My form data is invalid!');
                      Fluttertoast.showToast(
                        msg: "User name is empty!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    }
                  },
                  child: Row(
                    children: [
                      Text('SignUp'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                )

              ],),
            ),
          ),
        )
    );
  }
  
  String validateEmail(String value) {
    print("validateEmail : $value ");

    if (value.isEmpty) return "enter email";

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return "the email address is not valid";
    }
    return null;
  }
}