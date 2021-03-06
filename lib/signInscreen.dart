import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  final dateOfBirthController=TextEditingController();
  List<String> months=['','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'NOv','Dec'];
  Set<String> set1={'Value1'};
  Map<String, int> nameAge={};
  DateTime dateOfBirth;
  File _image;
  final picker = ImagePicker();
  bool isLoading;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    isLoading=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text('${widget.previousName} Screeen'),),
      drawer: Container(
        color: Colors.transparent,
        child: ClipPath(
          clipper: ClippingClass(),
          child: Drawer(
            child: Container(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body:
        ModalProgressHUD(
          inAsyncCall: isLoading,
          dismissible: true,
          child: SingleChildScrollView(
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
                        TextFormField(
                          onTap: (){
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), 
                              firstDate: DateTime.now(), 
                              lastDate: DateTime(2021),
                              ).then((value) {
                                setState((){
                                  isLoading=true;
                                });
                                dateOfBirth=value;
                                dateOfBirthController.text='${value.day}-${months[value.month]}-${value.year}';
                              });
                          },
                          controller: dateOfBirthController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          maxLength: 3,
                          decoration: InputDecoration(
                            hintText: "Date of Birth",
                            
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
                      showDialog(context: context,
                        builder: (context)=>ConfirmDialog()
                      );
                      // showDialog(context: context,
                      //   builder: (context)=>AlertDialog(
                      //     title: Text('Are you sure?'),
                      //     content: Container(
                      //       height: 200,
                      //       child: Text('do you wants to sign up?')
                      //       // child: Column(
                      //       //   children: [
                      //       //     Row(children: [
                      //       //       Icon(Icons.confirmation_number),
                      //       //       Text('Hello'),
                      //       //     ],),
                      //       //     Text('Hello World'),
                      //       //   ],
                      //       // ),
                      //     ),
                      //     actions: [
                      //       RaisedButton(
                      //         onPressed: (){
                      //           Navigator.pop(context);
                      //         },
                      //         child: Text('Cancel'),
                      //       ),
                      //       RaisedButton(
                      //         onPressed: (){
                      //           Navigator.pop(context);
                      //         },
                      //         color: Colors.blue,
                      //         child: Text('Save'),
                      //       ),
                      //     ],
                      //   )
                      // );
                      setState(() {
                        isLoading=true;
                      });
                      Future.delayed(Duration(seconds: 10),(){
                        setState(() {
                          isLoading=false;
                        });
                      });
                      nameAge.addAll({"${userName.text}":int.parse('${ageController.text}'),});
                      print(nameAge);
                      // print('''
                      // User Name: ${userName.text}, 
                      // Email : ${email.text}
                      // ''');

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



class ClippingClass extends CustomClipper<Path> {
  @override
   Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    //path.quadraticBezierTo(size.width*0.5, size.height*0.95, size.width, size.height*0.8);
    path.lineTo(size.width, size.height* 0.1);
    path.lineTo(0, 0);
    path.close();

    return path;
   }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


class ConfirmDialog extends StatefulWidget {
  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 80),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child: Center(
                child: Column(
                  children: [
                    Text('Are you sure?\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    
                    Text('Ypu wants to sign up?'),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 20, top: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RaisedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Text('Cancel'),
                            ),
                            SizedBox(width: 10,),
                            RaisedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              color: Colors.blue,
                              child: Text('Ok'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          
          Positioned(
            top: 150,
            left: MediaQuery.of(context).size.width * 0.5 - 35,
            child: Container(
                          height: 70,
                          width: 70,
                          child: CircleAvatar(child: Icon(Icons.ac_unit))),
          ),
        
        ],
      ),
    );
  }
}