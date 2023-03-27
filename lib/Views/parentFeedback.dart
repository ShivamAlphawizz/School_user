import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/api_path.dart';
import '../Utils/color.dart';
import 'Recruiter/recruiterdrawer_Screen.dart';


class ParentFeedback extends StatefulWidget {
  const ParentFeedback({Key? key}) : super(key: key);

  @override
  State<ParentFeedback> createState() => _ParentFeedbackState();
}

class _ParentFeedbackState extends State<ParentFeedback> {
  TextEditingController feedbackController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  getfeedback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user_id = prefs.getString('userid');
    print("Get Profile Api Working${user_id}");
    var headers = {
      'Cookie': 'ci_session=adf49898cd74faa6fd5bdafa39c65c8c96fc5889'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}parent_comment_status'));
    request.fields.addAll({
      'parent_id': user_id.toString(),
      'status': feedbackController.text
    });
    print(" this mfdgg${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result = await response.stream.bytesToString();
      var finalData = json.decode(result);
      print("this is a final responce======>${finalData}");
      var snackBar = SnackBar(
        content: Text('${finalData['msg']}'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        feedbackController.clear();
      });
      Navigator.pop(context);
    }
    else {
      print(response.reasonPhrase);
    }

  }
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: primaryColor,
              leading: GestureDetector(
                onTap: (){
                  Get.to(DrawerScreen());
                },
                child: Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
                //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
              ),
              title:  Text('Parent Feedback', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Serif'),),

            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(90)),
                  color: Colors.white
              ),
              width: size.width,
              height: size.height,
              child:Form(
                key: _formKey,
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20,),
                          Card(
                            elevation: 10,
                            child: Container(
                              height: 60,
                              child: TextFormField(
                                validator: (v){
                                  if(v!.isEmpty){
                                    return "Feedback is required";
                                  }
                                },
                                controller: feedbackController,
                                decoration:
                                InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10,top: 10),
                                  border: InputBorder.none,
                                  hintText: "Feedback ",
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              isLoading = true;
                            });
                            if(_formKey.currentState!.validate()){
                              getfeedback();
                            }
                            else{
                              setState(() {
                                isLoading = false;
                              });
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primaryColor),color: primaryColor

                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width/2,
                            child: Center(child: isLoading == true  ?  CircularProgressIndicator() : Text('Feedback',style: TextStyle(color:whiteColor, fontFamily: 'Serif'),)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ));
  }
}
