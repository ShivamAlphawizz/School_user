import 'dart:async';
import 'package:flutter/material.dart';
import 'package:job_dekho_app/Views/Recruiter/HomeScreen.dart';
import 'package:job_dekho_app/Views/signin_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    String? userid;
  void checkLogin()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  userid = pref.getString('userid');
  }

  @override
  void initState() {
    // TODO: implement initState
    //Timer(Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));});
    super.initState();
    // Future.delayed(Duration(milliseconds: 300),(){
    //   return checkLogin();
    // });

    Future.delayed(Duration(milliseconds: 1500),(){
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowGif()));
    // if(userid == null || userid == ""){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
    // }
    // else{
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image:DecorationImage(
            image:AssetImage('assets/splashscreen.png', ),
            fit: BoxFit.cover
            )
          )
        ),
      ),
    );
  }
}



class ShowGif extends StatefulWidget {
  const ShowGif({Key? key}) : super(key: key);

  @override
  State<ShowGif> createState() => _ShowGifState();
}

class _ShowGifState extends State<ShowGif> {

  String? userid;
  void checkLogin()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    userid = pref.getString('userid');
  }

  @override
  void initState() {
    // TODO: implement initState
    //Timer(Duration(seconds: 5), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));});
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      return checkLogin();
    });

    Future.delayed(Duration(seconds: 3),(){
      if(userid == null || userid == ""){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              'assets/handShake.gif',
            ),
            fit: BoxFit.cover
          )
        ),
      ),
    ));
  }
}
