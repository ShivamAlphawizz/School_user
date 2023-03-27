import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:job_dekho_app/Utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/myPlanModel.dart';
import '../Utils/api_path.dart';
import 'Recruiter/recruiterdrawer_Screen.dart';
import 'package:http/http.dart'as http;

class MySubscription extends StatefulWidget {
  const MySubscription({Key? key}) : super(key: key);

  @override
  State<MySubscription> createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySubscription();
  }
  MyPlanModel? myPlanModel;
  mySubscription()async{
    // myIds.clear();
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
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = MyPlanModel.fromJson(json.decode(finalResult));
      setState(() {
        myPlanModel = jsonResponse;
      });
      // for(var i=0;i<myPlanModel!.data!.length;i++){
      //   myIds.add(myPlanModel!.data![i].planId.toString());
      // }
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
              title:  Text('My Subscription ', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Serif'),),

            ),
            body:
            // privacyData == null || privacyData == "" ? Center(child: CircularProgressIndicator(),) :
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(90)),
                  color: Colors.white
              ),
              width: size.width,
              height: size.height,
              child:  myPlanModel == null || myPlanModel == "" ?Center(child: Text("No Item Found")):     ListView.builder(
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: myPlanModel!.data!.length,
                  // scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {

                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        elevation: 5,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Status",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Serif'),),
                                  Text("${myPlanModel!.data![index].tStatus}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: 'Serif'),),


                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Price",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),),
                                  Text("\u{20B9} ${myPlanModel!.data![index].price}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),),

                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Duration",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),),
                                  Text("${myPlanModel!.data![index].timeText}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),)
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Start Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),),
                                  Text("${myPlanModel!.data![index].startDate}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),)
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Last Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),),
                                  Text("${myPlanModel!.data![index].lastDate}",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Serif'),)
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
        ));
  }
}
