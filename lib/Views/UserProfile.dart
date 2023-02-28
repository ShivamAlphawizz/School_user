import 'dart:convert';
import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:job_dekho_app/Model/AddJobDataModel.dart';
// import 'package:job_dekho_app/Model/get_profile_model.dart';
// import 'package:job_dekho_app/Services/api_path.dart';
// import 'package:job_dekho_app/Services/tokenString.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/TextFields/customTextFormField.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/CustomWidgets/customTextButton.dart';
// import '../../Utils/style.dart';
import '../Utils/ApiModel/getprofile.dart';
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'Job Seeker/seekerdrawer_Screen.dart';
// import 'seekerdrawer_Screen.dart';

class UserProfile extends StatefulWidget {
  UserProfile({this.id});
  final String? id;


  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var gender;
  var selectedPreferedLocation;
  var specialization;
  var selectedExperience;
  var selectedRole;
  var selectedCurrentRole;
  var selectedDesignation;
  var selectedJobType;
  var selectedQualification;
  var resume;
  var status;
  var profileImage;
  var noticePeriods;

  var yearOfPassing,currentCTC,expected;

  String genders = "";

  Getprofile? seekerProfileModel;

  String? resumeData;

  var gaurdianData;
  getGuardianData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid  = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=055b59d73b5b89adf30482e59e4eb111b23c7f4f'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}get_gaurdians_details1'));
    request.fields.addAll({
      'id': '${userid}'
    });
    print("get gaurdian here ${ApiPath.baseUrl}get_gaurdians_details1   and ${userid}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);
      setState(() {
        gaurdianData = jsonResponse['data'][0];
      });
      nameController.text = gaurdianData['guardian_name'].toString();
      emailController.text = gaurdianData['guardian_email'].toString();
      addreessController.text = gaurdianData['guardian_address'].toString();
      mobileController.text = gaurdianData['guardian_mobile'].toString();
      distanceController.text = gaurdianData['distance'].toString();

    }
    else {
      print(response.reasonPhrase);
    }

  }


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addreessController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController distanceController = TextEditingController();



  intialFunction()async{
    print("working this api here");
    setState(() {
      // selectedPreferedLocation = seekerProfileModel!.data!.location == "0" || seekerProfileModel!.data!.location == null ? null : seekerProfileModel!.data!.location.toString() ;
      // specialization = seekerProfileModel!.data!.specialization == "0" || seekerProfileModel!.data!.specialization == "" || seekerProfileModel!.data!.specialization == null  ? null : seekerProfileModel!.data!.specialization.toString();
      // selectedExperience = seekerProfileModel!.data!.exp == "0" || seekerProfileModel!.data!.exp == null ? null : seekerProfileModel!.data!.exp.toString();
      // selectedRole = seekerProfileModel!.data!.jobRole == "0" || seekerProfileModel!.data!.jobRole == null || seekerProfileModel!.data!.jobRole == "" ? null : seekerProfileModel!.data!.jobRole.toString() ;
      // selectedDesignation = seekerProfileModel!.data!.designation == "0" || seekerProfileModel!.data!.designation == null || seekerProfileModel!.data!.designation == "" ? null :seekerProfileModel!.data!.designation.toString() ;
      // selectedJobType = seekerProfileModel!.data!.jobType == "0" || seekerProfileModel!.data!.jobType == null || seekerProfileModel!.data!.jobType == " " ? null : seekerProfileModel!.data!.jobType.toString() ;
      // selectedQualification = seekerProfileModel!.data!.qua == "0" || seekerProfileModel!.data!.qua == null || seekerProfileModel!.data!.qua == "null" ? null : seekerProfileModel!.data!.qua.toString();
      // gender = seekerProfileModel!.data!.gender == "0" || seekerProfileModel!.data!.gender == null  ?  "" : seekerProfileModel!.data!.gender.toString();
      // // filesPath = seekerProfileModel!.data!.resume == "0" || seekerProfileModel!.data!.resume == null  ? "" : seekerProfileModel!.data!.resume;
      // resumeData =  seekerProfileModel!.data!.resume == "0" || seekerProfileModel!.data!.resume == null  ? "" : seekerProfileModel!.data!.resume;
      // status = seekerProfileModel!.data!.status == "0" || seekerProfileModel!.data!.status == null  ? "" : seekerProfileModel!.data!.status;
      // profileImage = seekerProfileModel!.data!.img == "0" || seekerProfileModel!.data!.img == null ? "" : seekerProfileModel!.data!.img;
    });
    print("resume data here ${resumeData}");
  }

  var filesPath;
  String? fileName;

  // void _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  //   if (result == null) return;
  //   setState(() {
  //     filesPath = result.files.first.path ?? "";
  //     fileName = result.files.first.name;
  //     // reportList.add(result.files.first.path.toString());
  //     resumeData = null;
  //   });
  //   var snackBar = SnackBar(
  //     backgroundColor: primaryColor,
  //     content: Text('Profile upload successfully',style: TextStyle(fontFamily: 'Serif'),),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 300),(){
      // return addJobDataFunction();
      return getGuardianData();
    });
  }

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }


  Future<bool> showExitPopup() async {
    return await showDialog(//show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App',style: TextStyle(fontFamily: 'Serif'),),
        content: Text('Do you want to exit an App?',style: TextStyle(fontFamily: 'Serif'),),
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
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.to(DrawerScreen());
          },
          child: Image.asset('assets/ProfileAssets/menu_icon.png', scale: 1.6,),
        ),
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('My Profile',style: TextStyle(fontFamily: 'Serif'),),
        centerTitle: true,
      ),
      // backgroundColor: primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(90), topLeft: Radius.circular(90)),
          color: profileBg,
        ),
        alignment: Alignment.center,
        width: size.width,
        height: size.height / 0.35,
        child: SingleChildScrollView(
          child:
          // seekerProfileModel == null  || addJobDataModel == null  ? Center(child: CircularProgressIndicator(),) :
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GestureDetector(
              //   onTap: (){
              //     showModalBottomSheet(
              //         context: context,
              //         builder: (context){
              //           return Container(
              //             height: 250,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
              //             ),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(" Job Portal: Take Image From", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
              //                 ListTile(leading: Image.asset('assets/ProfileAssets/cameraicon.png', scale: 1.5,),
              //                   title: Text('Camera', style: TextStyle(fontWeight: FontWeight.bold)),
              //                   onTap: (){
              //                     _getFromCamera();
              //                   },
              //                 ),
              //                 ListTile(leading: Image.asset('assets/ProfileAssets/galleryicon.png', scale: 1.5,),
              //                   title: const Text('Gallery', style: TextStyle(fontWeight: FontWeight.bold)),
              //                   onTap: (){
              //                     _getFromGallery();
              //                   },
              //                 ),
              //                 ListTile(leading: Image.asset('assets/ProfileAssets/cancelicon.png', scale: 1.5,),
              //                   title: const Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold)),
              //                   onTap: (){
              //                     Navigator.pop(context);
              //                   },
              //                 )
              //               ],
              //             ),
              //           );
              //         });
              //   },
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Stack(
              //       children: [
              //         profileImage == null || profileImage == "" || imageFile != null ?  Container(
              //           width: 150,
              //           height: 150,
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: whiteColor
              //           ),
              //           child:imageFile != null ? ClipRRect(
              //               borderRadius: BorderRadius.circular(100),
              //               child:Image.file(imageFile!,fit: BoxFit.cover,)) : Image.asset('assets/ProfileAssets/sampleprofile.png'),
              //         ) :
              //         Container(
              //           width: 150,
              //           height: 150,
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: whiteColor
              //           ),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(100),
              //             child:Image.network("${profileImage}",fit: BoxFit.fill,),
              //           ),
              //         ),
              //         Positioned(
              //           bottom: 20,
              //           right: 10,
              //           child: Container(
              //             width: 30,
              //             height: 30,
              //             decoration: const BoxDecoration(
              //                 color: Colors.white,
              //                 shape: BoxShape.circle
              //             ),
              //             child: Image.asset('assets/ProfileAssets/camera_Icon.png', scale: 1.8,),
              //           ),),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 10,),
             gaurdianData == null || gaurdianData == "" ? Center(child:CircularProgressIndicator(),) : Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Guardian Name", style: TextStyle(color: greyColor2,fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'Serif'),),
                      SizedBox(height: 8,),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                              //borderSide: BorderSide(width: 3,color: Colors.black)
                            ) ,
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),borderSide: BorderSide(
                                width: 2,
                                color: primaryColor
                            )
                            ) ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email', style: TextStyle(color: greyColor2,fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'Serif'),),
                      SizedBox(height: 8,),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          controller: emailController,
                          readOnly: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                              //borderSide: BorderSide(width: 3,color: Colors.black)
                            ) ,
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),borderSide: BorderSide(
                                width: 2,
                                color: primaryColor
                            )
                            ) ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mobile", style: TextStyle(color: greyColor2,fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'Serif'),),
                      SizedBox(height: 8,),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          controller: mobileController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                              //borderSide: BorderSide(width: 3,color: Colors.black)
                            ) ,
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),borderSide: BorderSide(
                                width: 2,
                                color: primaryColor
                            )
                            ) ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Address", style: TextStyle(color: greyColor2,fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'Serif'),),
                      SizedBox(height: 8,),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          controller: addreessController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                              //borderSide: BorderSide(width: 3,color: Colors.black)
                            ) ,
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),borderSide: BorderSide(
                                width: 2,
                                color: primaryColor
                            )
                            ) ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Distance", style: TextStyle(color: greyColor2,fontSize: 15, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8,),
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(15),
                        child: TextFormField(
                          controller: distanceController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                              //borderSide: BorderSide(width: 3,color: Colors.black)
                            ) ,
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),borderSide: BorderSide(
                                width: 2,
                                color: primaryColor
                            )
                            ) ,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              // CustomTextFormField(label: "Student Name*", labelColor: greyColor2,fieldcontroller: firstNameController,),
              // CustomTextFormField(label: "Email*", labelColor: greyColor2,fieldcontroller: emailController,),
              // CustomTextFormField(label: "Password*", labelColor: greyColor2,fieldcontroller: passwordController,),
              // CustomTextFormField(label: "Mobile*", labelColor: greyColor2,fieldcontroller: mobileController,keyboardType: TextInputType.number,),
              // CustomTextFormField(label: "Age*", labelColor: greyColor2,fieldcontroller: ageController, keyboardType: TextInputType.number,),
              // CustomTextFormField(label: "Date Of Birth*", labelColor: greyColor2, fieldcontroller: dateofbirthaController,),
              // CustomTextFormField(label: "Parents Occupation*", labelColor: greyColor2, fieldcontroller: parentsController,),
              // CustomTextFormField(label: "Gender*", labelColor: greyColor2,),
              // CustomTextFormField(label: "Class*", labelColor: greyColor2, fieldcontroller: classController,),
              // CustomTextFormField(label: "Birth Certificate Number*", labelColor: greyColor2,),
              // CustomTextFormField(label: "Referal Code", labelColor: greyColor2,),
            ],
    ))))
    );
  }
}
     