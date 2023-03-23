// // import 'dart:html';
//
// import 'dart:convert';
// // import 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// // import 'package:image_picker/image_picker.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/jobseeker_Tab.dart';
// import 'package:job_dekho_app/Utils/CustomWidgets/recruiter_Tab.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../Utils/CustomWidgets/customTextButton.dart';
// import '../Utils/api_path.dart';
// import '../Utils/color.dart';
// import 'accountcreated_Screen.dart';
// import 'forgotpassword_Screen.dart';
// import 'package:http/http.dart' as http;
//
// class SignUpScreen extends StatefulWidget {
//   SignUpScreen({this.id});
//   final String? id;
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//
//   // final ImagePicker _picker = ImagePicker();
//   // File? imageFile;
//
//   // _getFromGallery() async {
//   //   PickedFile? pickedFile = await ImagePicker().getImage(
//   //     source: ImageSource.gallery,
//   //   );
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       imageFile = File(pickedFile.path);
//   //     });
//   //     Navigator.pop(context);
//   //   }
//   // }
//   // _getFromCamera() async {
//   //   PickedFile? pickedFile = await ImagePicker().getImage(
//   //     source: ImageSource.camera,
//   //   );
//   //   if (pickedFile != null) {
//   //     setState(() {
//   //       imageFile = File(pickedFile.path);
//   //     });
//   //     Navigator.pop(context);
//   //   }
//   // }
//
//   updateProfile() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString(widget.id.toString());
//     print("User Id Here ${userid.toString()}");
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}updateProfile'));
//     request.fields.addAll({
//       'id': '$userid',
//       'name': '${nameController.toString()}',
//       'email': '${emailController.text}',
//       'password': '${passwordController.text}',
//       'mobile' : '${mobileController.text}',
//     });
//     request.files.add(await http.MultipartFile.fromPath('profile_pic', '/C:/Users/Alphawizz/Downloads/Screenshot_20230127-163443~2.jpg'));
//     print("Checking all Update Details ${request.fields}");
//     // request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print("Print Response ${jsonResponse}");
//       if(jsonResponse['status'] == "success"){
//         Fluttertoast.showToast(msg: "${jsonResponse['message']}");
//         Navigator.pop(context,true);
//       }
//       // setState(() {
//       // });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   getProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString(widget.id.toString());
//     var headers = {
//       'Cookie': 'ci_session=d58a0bde8d3e3add78cf667d341d4e5f60e95363'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/e_gate/Api/get_profile'));
//     request.fields.addAll({
//       'id': '$userid',
//     });
//
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResponse);
//       print("Response@@@@@@@ ${jsonResponse}");
//       print(await response.stream.bytesToString());
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//   var profileImage;
//
//   Widget imageProfile() {
//     return Material(
//       elevation: 2,
//       borderRadius: BorderRadius.circular(15),
//       child: InkWell(
//         onTap: () {
//           // requestPermission(context, 5);
//           // uploadRCFromCamOrGallary(context);
//         },
//         child: Center(
//           child: Container(
//             height: 100,
//             width: 100,
//             decoration: BoxDecoration(
//                 // border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(15)),
//             child:
//             // widget.model!.profileImage == null || widget.model!.profileImage == "" ?
//             ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: profileImage!= null
//                   ? Image.file(profileImage, fit: BoxFit.cover)
//                   : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(child: Icon(Icons.person, size: 60)),
//                   Text("Profile Image")
//                 ],
//               ),
//             ),
//             //   : ClipRRect(
//             // borderRadius: BorderRadius.circular(15),
//             // child:
//             // // rcImage != null ?
//             // Image.network(widget.model!.profileImage.toString(), fit: BoxFit.cover)
//             // //     : Column(
//             // //   mainAxisAlignment: MainAxisAlignment.center,
//             // //   children: [
//             // //     Center(child: Icon(Icons.person, size: 60)),
//             // //     Text("Profile Image")
//             // //   ],
//             // // ),
//             // )
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea
//       (child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           backgroundColor: primaryColor,
//           body: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   height: size.height / 5.5 ,
//                   decoration: BoxDecoration(
//                     color: primaryColor,
//                   ),
//                   child: Image.asset('assets/egate_logo.png', scale: 1.3,),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(14),
//                   width: size.width,
//                   height: size.height /1.25,
//                   decoration: BoxDecoration(
//                       color: whiteColor,
//                       borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const CircleAvatar(
//                         // backgroundColor: Colors.black,
//                         radius: 110,
//                         child: CircleAvatar(
//                           radius: 100,
//                           backgroundImage: AssetImage('assets/ProfileAssets/sampleprofile.png'),
//                         ),
//                       ),
//                       const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
//                       SizedBox(height: 25,),
//                       SizedBox(height: MediaQuery.of(context).size.height / 1.75,
//                         child:
//                         TabBarView(
//                             children: [
//                               Column(
//                                   children: [
//                                     Container(
//                                       child: Column(
//                                         children: [
//                                           SizedBox(height: 20,),
//                                           Material(
//                                             elevation: 10,
//                                             borderRadius: BorderRadius.circular(10),
//                                             child: Container(
//                                               width: MediaQuery.of(context).size.width / 1.2,
//                                               height: 58,
//                                               child: TextField(
//                                                 controller: nameController,
//                                                 decoration: InputDecoration(
//                                                   border: const OutlineInputBorder(
//                                                       borderSide: BorderSide.none
//                                                   ),
//                                                   hintText: "Name",
//                                                   prefixIcon: Image.asset('assets/AuthAssets/Icon awesome-user.png', scale: 1.3, color: primaryColor,),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(height: 20,),
//                                           Material(
//                                             elevation: 10,
//                                             borderRadius: BorderRadius.circular(10),
//                                             child: Container(
//                                               width: MediaQuery.of(context).size.width / 1.2,
//                                               height: 58,
//                                               child: TextField(
//                                                 controller: passwordController,
//                                                 decoration: InputDecoration(
//                                                   border: const OutlineInputBorder(
//                                                       borderSide: BorderSide.none,
//                                                   ),
//                                                   hintText: "Enter Password",
//                                                   prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-lock.png', scale: 1.3, color: primaryColor,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(height: 20,),
//                                           Material(
//                                             elevation: 10,
//                                             borderRadius: BorderRadius.circular(10),
//                                             child: Container(
//                                               width: MediaQuery.of(context).size.width / 1.2,
//                                               height: 58,
//                                               child: TextField(
//                                                 controller: emailController,
//                                                 decoration: InputDecoration(
//                                                   border: const OutlineInputBorder(
//                                                       borderSide: BorderSide.none
//                                                   ),
//                                                   hintText: "Email",
//                                                   prefixIcon: Image.asset('assets/AuthAssets/Icon material-email.png', scale: 1.3, color: primaryColor,),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(height: 20,),
//                                           Material(
//                                             elevation: 10,
//                                             borderRadius: BorderRadius.circular(10),
//                                             child: Container(
//                                               width: MediaQuery.of(context).size.width / 1.2,
//                                               height: 58,
//                                               child: TextField(
//                                                 controller: mobileController,
//                                                 decoration: InputDecoration(
//                                                   border: const OutlineInputBorder(
//                                                       borderSide: BorderSide.none
//                                                   ),
//                                                   hintText: "Mobile No.",
//                                                   prefixIcon: Image.asset('assets/AuthAssets/Icon ionic-ios-call.png', scale: 1.3, color: primaryColor,),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(height: 50,),
//                                           CustomTextButton(buttonText: 'Submit', onTap: (){Get.to(AccountCreatedScreen());},),
//                                           // CustomTextButton(buttonText: 'Sign In', onTap: (){
//                                           //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> SeekerDrawerScreen()));
//                                           // }),
//                                         ],
//                                       ),
//                                     ),
//                                   ]),
//                             ]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//     ),
//       ));
//   }
// }


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/jobseeker_Tab.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/recruiter_Tab.dart';
import 'package:job_dekho_app/Views/signin_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/myPlanModel.dart';
import '../Utils/ApiModel/ShowDetailsModel.dart';
import '../Utils/ApiModel/SignUpModel.dart';
import '../Utils/CustomWidgets/SchoolTab.dart';
import '../Utils/CustomWidgets/TextFields/authTextField.dart';
import '../Utils/CustomWidgets/customTextButton.dart';
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'accountcreated_Screen.dart';
import 'package:http/http.dart' as http;
// import '../Utils/style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController codeController = TextEditingController();

  bool isLoading = false;
  Data? detailsModel;
  showDetails() async {
    print("Show Details Api@@@@@@");
    var headers = {
      'Cookie': 'ci_session=e51f2b8d8f46fc0ca9897e617308398adca216f1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}show_details'));
    request.fields.addAll({
      'search_keyword': codeController.text.toString(),
    });
    print(" show detail api  ${ApiPath.baseUrl}show_details and ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("working@@@@@@@");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = ShowDetailsModel.fromJson(json.decode(finalResponse));
      setState(() {
       detailsModel = jsonResponse.data;
      });
    // print("details are here now ${detailsModel!.driverId} and ${detailsModel!.schoolId} and ${detailsModel!.parentId}");
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500),(){
      return mySubscription();
    });
  }

  MyPlanModel? myPlanModel;

  var planId;
  mySubscription()async{
    // myIds.clear();
    print("ddddddddddddddddddddddddddddddddddd");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=389aea2e859d277e722d83d012e6f41185f47fe3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}my_plans'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print("sdsfdsfsfs ${response.statusCode}");
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MyPlanModel.fromJson(json.decode(finalResult));

      // if(myPlanModel == null){
      //   print("sdsfsdfs");
      // }
      // else if(myPlanModel!.data == null){
      //   print("mmmmmmmmmmmm");
      // }
      // else{
      //   print("bbbbbbbbbbbbb");
      //   setState(() {
      //     myPlanModel = jsonResponse;
      //     planId = myPlanModel!.data![0].planId.toString();
      //   });
      //   print("dddddddddd ${planId}");
      // }
        setState(() {
          myPlanModel = jsonResponse;
        });
        if(myPlanModel == null){

        }
        else{
          setState(() {
            planId = myPlanModel!.data![0].planId.toString();
          });
          print("plan id hre  ${planId}");
        }


      // for(var i=0;i<myPlanModel!.data!.length;i++){
      //   myIds.add(myPlanModel!.data![i].planId.toString());
      // }
    }
    else {
      print(response.reasonPhrase);
    }

  }

  final _formKey = GlobalKey<FormState>();

  String shiftValue = '';
  registerUser() async {
   // Shared
    print("Register User Api>>>>>>");
    var headers = {
      'Cookie': 'ci_session=922f5c650083c77ae33c78aca232c748038bffe8'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}add_student'));
    request.fields.addAll({
      'name': studentnameController.text,
      'dob': dateOfBirth.toString(),
      'age': ageController.text,
      'add_class': classController.text,
      'religion': religionController.text,
      'driver_id': detailsModel!.driverId.toString(),
      'school_id': detailsModel!.schoolId.toString(),
      'relation': parentrelationController.text,
      'occupation': parentOccupation.text,
      'sex': gender.toString(),
      'parent_id': detailsModel!.parentId.toString(),
      'birth_no': addharController.text,
      'roll_no':rollNoController.text,
      'blood':bloodGroupController.text,
      'division': divisionController.text,
      'emergency_no': emergencyController.text,
        'plan_id': planId.toString(),
      'shift': shiftValue.toString(),
    });
    request.headers.addAll(headers);

    print("checking parameters of user register ${request.fields}");
    print("api here ${ApiPath.baseUrl}add_student");
    http.StreamedResponse response = await request.send();
    print("Working Api Here>>>>>");
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = SignUpModel.fromJson(json.decode(finalResponse));
      setState(() {
        print("final response is here>>>>> ${jsonResponse.data.toString()}");
      });
     Fluttertoast.showToast(msg: "${jsonResponse.message}");
    Navigator.pop(context,true);
    }
    else {
      // Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      print(response.reasonPhrase);
    }
  }

  TextEditingController studentnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController religionController = TextEditingController();
  TextEditingController parentOccupation = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController classController  = TextEditingController();
  TextEditingController parentrelationController = TextEditingController();
  TextEditingController addharController = TextEditingController();
  TextEditingController divisionController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController emergencyController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  String? profileImage;
  String? gender;
  String? dateOfBirth;



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea
      (child: DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: primaryColor,
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 10.5,
                  alignment: Alignment.center,
                  // padding: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: Text('Student Registration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white,fontFamily: 'Serif'),textAlign: TextAlign.center,)
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: size.width,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        // borderRadius: BorderRadius.only(topRight: Radius.circular(70), topLeft: Radius.circular(70)),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    //  mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text('Student Registration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),textAlign: TextAlign.center,),
                        // SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Gaurdian Code",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 17,fontFamily: 'Serif'),),
                            SizedBox(height: 8,),
                            Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                height: 48,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: codeController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                      ),
                                      hintText: "Gaurdian Code",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        CustomTextButton(buttonText: 'Submit', onTap: (){
                        //  Get.to(showDetails());
                          if(codeController.text.isEmpty){
                            Fluttertoast.showToast(msg: "Please enter code");
                          }
                          else{
                            showDetails();
                          }
                          },
                        ),
                        SizedBox(height: 15,),
                        detailsModel != null ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("School Name", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text('${detailsModel!.schName}'),
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text("School Mobile", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text('${detailsModel!.mobile}'),
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text("School Email", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text('${detailsModel!.email}',style: TextStyle(fontFamily: 'Serif'),),
                              ),
                            ),
                            // SizedBox(height: 12,),
                            // Text("School Name"),
                            // Material(
                            //   elevation: 4,
                            //   borderRadius: BorderRadius.circular(11),
                            //   child: Container(
                            //     padding: EdgeInsets.all(15),
                            //     width: MediaQuery.of(context).size.width
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(40)
                            //     ),
                            //     child: Text('${detailsModel!.gender}'),
                            //   ),
                            // ),
                            SizedBox(height: 12,),
                            Text("School Dise Code", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text('${detailsModel!.schCode}'),
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text("Driver Name", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text('${detailsModel!.driName}'),
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text("Driver Email", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text('${detailsModel!.driEmail}')
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text("Driver Shift",style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text('${detailsModel!.driShift}')
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text("Driver Vehicle Number",style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text("${detailsModel!.driVehicleNumber}")
                              ),
                            ),
                            SizedBox(height: 12,),
                            Text("Driver Vehicle Type", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                            Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(11),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40)
                                ),
                                child: Text("${detailsModel!.driVehicleType}")
                              ),
                            ),
                            SizedBox(height: 12,),
                          ],
                        )
                        : SizedBox.shrink(),
                        SizedBox(height: 15,),
                       // JobSeekerTab(),
                       /// student detail
                  detailsModel == null ?  SizedBox.shrink() :
                  Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Student Section",style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif'),),
                              SizedBox(height: 25,),
                              Text("Student Name", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: studentnameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter name';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Student name",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Student Age", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: ageController,
                                    maxLength: 2,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter age';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Student Age",
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 10,),
                              // Text("Student religion", style: TextStyle(fontWeight: FontWeight.w800)),
                              // Material(
                              //   elevation: 10,
                              //   borderRadius: BorderRadius.circular(10),
                              //   child: Container(
                              //     width: MediaQuery.of(context).size.width,
                              //     height: 60,
                              //     child: TextFormField(
                              //       controller: religionController,
                              //       validator: (value) {
                              //         if (value == null || value.isEmpty) {
                              //           return 'Please enter religion';
                              //         }
                              //         return null;
                              //       },
                              //       decoration: const InputDecoration(
                              //         border: OutlineInputBorder(
                              //           borderSide: BorderSide.none,
                              //         ),
                              //         hintText: "Student religion",
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: 10,),
                              Text("Parent Occupation", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: parentOccupation,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter parents occupation';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Parents occupation",
                                    ),
                                  ), 
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Date Of Birth", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              InkWell(
                                onTap: ()async{
                                  final DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(), 
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      // print("this is current date ${dateInput.toString()}");
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            // primary: primary, // <-- SEE HERE
                                            // onPrimary: Colors.redAccent, // <-- SEE HERE
                                            // onSurface: Colors.blueAccent, // <-- SEE HERE
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              // primary: primary, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },

                                  );
                                  if (pickedDate != null) {
                                 //   print( "This is picked date" + pickedDate.toString());
                                  //  pickedDate output format => 2021-03-10 00:00:00.000
                                    dateOfBirth = DateFormat('dd-MM-yyyy').format(pickedDate);
                                    // print("final formated date here" +
                                    //     dateOfBirth.toString()); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      // dateInput.text =
                                      //     formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                                child: Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    child: dateOfBirth == null || dateOfBirth == "" ? Text("Select date",style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Serif'),) : Text("${dateOfBirth}",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500,fontFamily: 'Serif'),)
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Admission Class", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: classController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Admission class';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Admission Class",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Parent Relation", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: parentrelationController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter parents relation';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Parents relation",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Addhar Number", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: addharController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 12,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter adhar number';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      counterText: "",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Addhar Number",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Roll Number", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: rollNoController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter roll no';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Roll Number",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text("Male",style: TextStyle(fontFamily: 'Serif'),),
                                        value: "male",
                                        groupValue: gender,
                                        onChanged: (value){
                                          setState(() {
                                            gender = value.toString();
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(  
                                        title: Text("Female",style: TextStyle(fontFamily: 'Serif'),),
                                        value: "female",
                                        groupValue: gender,
                                        onChanged: (value){
                                          setState(() {
                                            gender = value.toString();
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text("Morning",style: TextStyle(fontFamily: 'Serif'),),
                                        value: "morning",
                                        groupValue: shiftValue,
                                        onChanged: (value){
                                          setState(() {
                                            shiftValue = value.toString();
                                          });
                                          print("shift value ${shiftValue}");
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile(
                                        title: Text("Evening",style: TextStyle(fontFamily: 'Serif'),),
                                        value: "evening",
                                        groupValue: shiftValue,
                                        onChanged: (value){
                                          setState(() {
                                            shiftValue = value.toString();
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Blood Group", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: bloodGroupController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter blood group';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Blood Group",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Division", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    controller: divisionController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter division';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Division",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text("Emergency Number", style: TextStyle(fontWeight: FontWeight.w800,fontFamily: 'Serif')),
                              Material(
                                elevation: 10,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  child: TextFormField(
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    controller: emergencyController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter emergency number';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                  counterText: "",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Emergency Number",
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                     detailsModel == null ? SizedBox.shrink() : InkWell(
                          onTap: (){

                            if(_formKey.currentState!.validate()){
                              setState(() {
                                isLoading = true;
                              });
                            if(detailsModel == null || detailsModel == ""){
                              Fluttertoast.showToast(msg: "Please enter driver and school detail with code");
                              setState(() {
                                isLoading = false;
                              });
                            }
                            else if(addharController.text.length != 12){
                              Fluttertoast.showToast(msg: "Please enter valid addhar number");
                              setState(() {
                                isLoading = false;
                              });
                            }
                            else if(emergencyController.text.length !=10){
                              Fluttertoast.showToast(msg: "Enter valid mobile number");
                              setState(() {
                                isLoading = false;
                              });
                            }
                            else{

                              registerUser();
                            }
                            }
                            else{
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(msg: "All fields are required");
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width/2.5,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor
                            ),
                            child: isLoading == true ? CircularProgressIndicator() : Text("Submit",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14,fontFamily: 'Serif'),),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        // SizedBox(height: MediaQuery.of(context).size.height / 1.65,
                        //   child: TabBarView(
                        //       children: [
                        //         JobSeekerTab(),
                        //       ]),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    ));
  }
}

