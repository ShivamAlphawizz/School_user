import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Model/notificationModel.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customNotificaitonTile.dart';
import 'package:job_dekho_app/Utils/api_path.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterdrawer_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/color.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationModel? notificationModel;
  getNotification()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=e27b9a709e79f067f9b5f2e6f6541ff1595521a5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}notification_list'));
    request.fields.addAll({
      'user_id': '${userid}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = NotificationModel.fromJson(json.decode(finalResponse));
      setState(() {
        notificationModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300),(){
      return getNotification();
    });
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
               Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios, color: whiteColor, size: 20),
                //Icon(Icons.arrow_back_ios, color: whiteColor, size: 22),
              ),
              title:  Text('Notification', style: TextStyle(color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Serif'),),
            ),
          body: Container(
            padding: EdgeInsets.only(top: 50,bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(90)),
                color: Color(0xffF9F9F9)
            ),
            width: size.width,
            height: size.height,
            child:  notificationModel == null || notificationModel == "" ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: notificationModel!.notifications!.length,
                itemBuilder: (c,i){
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("${notificationModel!.notifications![i].title}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: 'Serif'),)),
                          Expanded(child: Text("${notificationModel!.notifications![i].date}", style: TextStyle(color: greyColor2,fontSize: 12, fontWeight: FontWeight.bold,fontFamily: 'Serif'),)),
                        ],
                      ),
                      Text("${notificationModel!.notifications![i].message}",maxLines: 2,style: TextStyle(fontFamily: 'Serif'),)
                    ],
                  ),
                ),
              );
            })
          )
        ));
  }
}
