// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/email_Tab.dart';
// import 'package:job_dekho_app/Utils/color.dart';
// import 'package:job_dekho_app/Views/forgotpassword_Screen.dart';
// import '../Utils/ApiModel/LoginModel.dart';
// import '../Utils/CustomWidgets/mobile_Tab.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../Utils/api_path.dart';
// import 'Recruiter/recruitermyprofile_Screen.dart';
// import 'signup_Screen.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//
//   // var _value = 0;
//   bool isEmail = true;
//
//   Future<LoginModel?> loginEmail() async {
//     print("Api Working@@@");
//     var headers = {
//       'Cookie': 'ci_session=ad447bdb61848f5c85e9459927a16a9bf91e1a0f'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.login}'));
//     request.fields.addAll({
//       'email': '${emailController.text}',
//       'password': '${passwordController.text}',
//     });
//
//     print(request);
//     print("this is new request =====>>> ${request.fields}");
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print("Nowwwww ${jsonResponse}");
//       if(jsonResponse['staus'] == 'true') {
//         // Fluttertoast.showToast(msg: '${jsonResponse['message']}');
//         print("Working Nowww ${jsonResponse['data']['id']}");
//         // String userId = jsonResponse['data']['id'];
//         // String userEmail = jsonResponse['data']['email'];
//       }
//       Navigator.push(context, MaterialPageRoute(builder: (context) => RecruiterMyProfileScreen()));
//     }
//     else {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print(jsonResponse.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea
//       (child: Scaffold(
//       backgroundColor: primaryColor,
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 170,
//               decoration: BoxDecoration(
//                 color: primaryColor,
//               ),
//               child: Image.asset('assets/egate_logo.png', scale: 1.3,),
//             ),
//             Container(
//               padding: EdgeInsets.all(14),
//               width: size.width,
//               height: size.height / 1.3,
//               decoration: BoxDecoration(
//                   color: whiteColor,
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),),
//                   SizedBox(height: 10,),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   //   children: [
//                       // Row(
//                       //   children: [
//                       //     // Radio(
//                       //     //   fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
//                       //     //   value: 1, groupValue: _value, onChanged: (value){setState((){isEmail = true;});},),
//                       //     // Text('Email', style: TextStyle(fontWeight: FontWeight.bold),),
//                       //   ],
//                       // ),
//                       // Row(
//                       //   children: [
//                       //     // Radio(
//                       //     //     activeColor: Colors.red,
//                       //     //     fillColor: MaterialStateColor.resolveWith((states) => primaryColor),
//                       //     //     value: 2, groupValue: _value, onChanged: (value){setState(() {isEmail = false;});}),
//                       //     // Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold),),
//                       //   ],
//                       // )
//                     // ],
//                   // ), // Email & Mobile Radio Button
//                   Column(children: [isEmail ? EmailTabs() : MobileTabs()]),
//                   SizedBox(height: 80,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text("Don't have an account? ", style: TextStyle(color: greyColor,fontWeight: FontWeight.bold),),
//                       GestureDetector(onTap: (){Get.to(SignUpScreen());},child: Text("Sign Up", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )
//     ));
//   }
// }


import 'dart:convert';
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/email_Tab.dart';
import 'package:job_dekho_app/Views/Job%20Seeker/seekerdrawer_Screen.dart';
import 'package:job_dekho_app/Views/Job%20Seeker/seekermyprofile_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/HomeScreen.dart';
import 'package:job_dekho_app/Views/Recruiter/postJob_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/recruitermyprofile_Screen.dart';
import 'package:job_dekho_app/Views/forgotpassword_Screen.dart';
import 'package:job_dekho_app/Views/otp_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/CustomWidgets/TextFields/authTextField.dart';
import '../Utils/CustomWidgets/customTextButton.dart';
import '../Utils/CustomWidgets/mobile_Tab.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'UserProfile.dart';
import 'signup_Screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var _value = 'Email';
  bool isEmail = true;
  bool isloader = false;
  bool showPassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();


  String? token;

  getToken() async {
     var fcmToken = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = fcmToken.toString();
    });
    print("FCM ID Is $token");
  }
  // String? userid;

  emailPasswordLogin() async{
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=ecadd729e7ab27560c282ba3660d365c7e306ca0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}login'));
    request.fields.addAll({
      'email': '${emailController.text}',
      'password': '${passwordController.text}',
      'token':token.toString(),
    });
    print("Checking all fields here ${request.fields} and ${ApiPath.baseUrl}login");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print("Working@@@@@@@@ ${jsonResponse}");
      if(jsonResponse['status'] == 'success'){
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        // print("Response Here ${jsonResponse['data']['id']}");
        print("json response new one here ${jsonResponse}");
        String userid = jsonResponse['user_id'];
        prefs.setString('userid', userid.toString());
        print("user id is here ${userid.toString()}");

        setState(() {
          isloader = false;
          print("final response>>>>> ${jsonResponse}");
        });
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
      }
      else{
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
        setState(() {
          isloader = false;
        });
      }
    }
    else {
      setState(() {
        isloader = false;
      });
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      print(jsonResponse.toString());
    }
  }

bool showPasword = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();

  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App',style: TextStyle(fontFamily: 'Serif'),),
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No',style: TextStyle(fontFamily: 'Serif'),),
          ),
          ElevatedButton(
            onPressed: (){
              exit(0);
              // Navigator.pop(context,true);
              // Navigator.pop(context,true);
            },
            //return true when click on "Yes"
            child:Text('Yes',style: TextStyle(fontFamily: 'Serif'),),
          ),
        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
          child: Scaffold(
              backgroundColor: primaryColor,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                      ),
                      child: Image.asset(
                        'assets/egate_logo.png', color: primaryColor,
                        // scale: 1.5,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(14),
                      width: size.width,
                      height: size.height / 1.1,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius:
                          BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),),
                      child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        shrinkWrap: true,
                        children: [
                          const Align(
                            alignment:Alignment.center,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 32,fontFamily: 'Serif'),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Expanded(
                          //             child: Row(
                          //               children: [
                          //                 Radio(
                          //                   fillColor: MaterialStateColor.resolveWith(
                          //                           (states) => primaryColor),
                          //                   activeColor: primaryColor,
                          //                   value: 'seeker',
                          //                   groupValue: _value1,
                          //                   onChanged: (value) {
                          //                     setState(() {
                          //                       _value1 = value.toString();
                          //                       isSeeker = true;
                          //                     });
                          //                   },
                          //                 ),
                          //                 Text(
                          //                   'Job Seeker',
                          //                   style: TextStyle(fontWeight: FontWeight.bold),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           Expanded(
                          //             child: Row(
                          //               children: [
                          //                 Radio(
                          //                     activeColor: Colors.red,
                          //                     fillColor: MaterialStateColor.resolveWith(
                          //                             (states) => primaryColor),
                          //                     value: 'recruiter',
                          //                     groupValue: _value1,
                          //                     onChanged: (value) {
                          //                       setState(() {
                          //                         _value1 = value.toString();
                          //                         isSeeker = false;
                          //                       });
                          //                     }),
                          //                 Text(
                          //                   'Recruiter',
                          //                   style: TextStyle(fontWeight: FontWeight.bold),
                          //                 ),
                          //               ],
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ), //
                          //     Container(
                          //       child: Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //         children: [
                          //           Expanded(
                          //             child: Row(
                          //               children: [
                          //                 Radio(
                          //                   fillColor: MaterialStateColor.resolveWith(
                          //                           (states) => primaryColor),
                          //                   activeColor: primaryColor,
                          //                   value: 'Email',
                          //                   groupValue: _value,
                          //                   onChanged: (value) {
                          //                     setState(() {
                          //                       _value = value.toString();
                          //                       isEmail = true;
                          //                     });
                          //                   },
                          //                 ),
                          //                 Text(
                          //                   'Email',
                          //                   style: TextStyle(fontWeight: FontWeight.bold),
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //           Expanded(
                          //             child: Row(
                          //               children: [
                          //                 Radio(
                          //                     activeColor: Colors.red,
                          //                     fillColor: MaterialStateColor.resolveWith(
                          //                             (states) => primaryColor),
                          //                     value: 'Mobile',
                          //                     groupValue: _value,
                          //                     onChanged: (value) {
                          //                       setState(() {
                          //                         _value = value.toString();
                          //                         isEmail = false;
                          //                       });
                          //                     }),
                          //                 Text(
                          //                   'Mobile',
                          //                   style: TextStyle(fontWeight: FontWeight.bold),
                          //                 ),
                          //               ],
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ), // Email & Mobile Radio Button
                          //   ],
                          // ),
                          Column(
                              children: [
                                /// email login section
                                // EmailTabs()
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Material(
                                          elevation: 10,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 1.2,
                                            height: 58,
                                            child: TextField(
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide.none
                                                  ),
                                                  hintText: "Enter userId",
                                                prefixIcon: Image.asset('assets/AuthAssets/Icon material-email.png', scale: 1.3, color: primaryColor,),
                                              ),),),
                                      ),
                                      SizedBox(height: 20,),
                                      Material(
                                          elevation: 10,
                                          borderRadius: BorderRadius.circular(10),
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 1.2,
                                            height: 58,
                                            child: TextField(
                                              obscureText: showPassword ==true ? false: true,
                                              controller: passwordController,
                                              decoration: InputDecoration(
                                                suffixIcon: InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        showPassword = !showPassword;
                                                      });
                                                    },
                                                    child: showPassword == true ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),
                                                hintText: "Enter Password",
                                                prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 1.3, color: primaryColor,),
                                              ),
                                            ),
                                          ),
                                      ),
                                      // SizedBox(height: 10,),
                                      // GestureDetector(
                                      //   onTap: (){
                                      //     Get.to(ForgotPasswordScreen());
                                      //   },
                                      //   child: Padding(
                                      //     padding: EdgeInsets.symmetric(horizontal: 20),
                                      //     child: Align(
                                      //         alignment: Alignment.centerRight,
                                      //         child: Text('Forgot Password?', style: TextStyle(color: greyColor1,fontWeight: FontWeight.bold,))),
                                      //   ),
                                      // ),
                                      SizedBox(height: 50,),
                                      // CustomTextButton(buttonText: 'Sign In', onTap: (){
                                      //   emailPasswordLogin();
                                      //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> SeekerDrawerScreen()));
                                      // }),

                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            isloader = true;
                                          });
                                          emailPasswordLogin();
                                        },
                                        child: Container(
                                          height: 50,
                                          width: MediaQuery.of(context).size.width/1.5,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: primaryColor,
                                          ),
                                          child: isloader == true ? Center(child: CircularProgressIndicator(color: Colors.white,),) : Text("Sign In",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'Serif'),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                          SizedBox(
                            height: 20,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       "Don't have an account? ",
                          //       style: TextStyle(
                          //           color: greyColor,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //     GestureDetector(
                          //         onTap: () {
                          //           Get.to(SignUpScreen());
                          //         },
                          //         child: Text(
                          //           "Sign Up",
                          //           style: TextStyle(
                          //               color: primaryColor,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
