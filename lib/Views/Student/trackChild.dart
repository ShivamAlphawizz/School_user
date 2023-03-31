import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:job_dekho_app/Views/Student/GetLocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Utils/api_path.dart';

class OrderTrackingPage extends StatefulWidget {

   String? dlat,dlong,glat,glong,slat,slong;
  OrderTrackingPage({this.glong,this.glat,this.dlong,this.dlat,this.slat,this.slong});


  @override
  State<OrderTrackingPage> createState() => _OrderTrackingPageState();
}

class _OrderTrackingPageState extends State<OrderTrackingPage> {

  final Completer<GoogleMapController> _controller = Completer();


  List<LatLng> polylineCoordinates = [];
  List<LatLng> schoolPolyCoordinates = [];
   getPolyPoints() async {
    print("lat and long here ${widget.glat}");
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyBmUCtQ_DlYKSU_BV7JdiyoOu1i4ybe-z0", // Your Google Map Key
      //"AIzaSyCRlWsC4r9pE2hOE-qzJmaT-jEt3g9NM9Y",  // live api key
      PointLatLng(double.parse(widget.glat.toString()), double.parse(widget.glong.toString())),
      PointLatLng(double.parse(widget.slat.toString()), double.parse(widget.slong.toString())),

    );

    // PolylineResult result1 = await polylinePoints.getRouteBetweenCoordinates(
    //     "AIzaSyBmUCtQ_DlYKSU_BV7JdiyoOu1i4ybe-z0",
    //   PointLatLng(double.parse(widget.dlat.toString()), double.parse(widget.dlong.toString())),
    //   PointLatLng(double.parse(widget.slat.toString()), double.parse(widget.slong.toString())),
    // );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      result.points.forEach(
            (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
    // if(result1.points.isNotEmpty){
    //   schoolPolyCoordinates.clear();
    //   result1.points.forEach((PointLatLng point) => polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
    //   setState(() {
    //
    //   });
    // }
  }


  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration(milliseconds: 500),(){
    //   return getPolyPoints();
    // });
  //  getCurrentLocation();
  //   Future.delayed(Duration(milliseconds: 500),(){
  //     return getLocation();
  //   });
 //   getLocation();

    super.initState();
    Future.delayed(Duration(milliseconds: 400),(){
      return getIcons();
    });
    // Future.delayed(Duration(milliseconds: 300),(){
    //   return getGaurdianDetail();
    // });

  }

  Position? position;
   getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
     position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print("lati" + position!.latitude.toString());
    print("longi" + position!.longitude.toString());
  }

  // BitmapDescriptor? icon;

  var driverIcon,schoolIcon,homeIcon;
  getIcons() async {
    driverIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 4.6),
        'assets/bus2.png');
    schoolIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 4.6), 'assets/schoolmage.png');
    homeIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 4.6), 'assets/homeImage.png');
  }


  getGaurdianDetail()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('userid');
    var headers = {
      'Cookie': 'ci_session=055b59d73b5b89adf30482e59e4eb111b23c7f4f'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiPath.baseUrl}get_gaurdians_details1'));
    request.fields.addAll({
      'id': '${userid}'
    });
    print("dddddddddddddddddd ${ApiPath.baseUrl}get_gaurdians_details1   and ${userid}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResult = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResult);

      print("checking final response here ${jsonResponse['data'][0]['latitude']}");

      setState(() {
       widget.dlat = jsonResponse['data'][0]['driver_lat'].toString();
        widget.dlong = jsonResponse['data'][0]['driver_lang'].toString();
        widget.glat =  jsonResponse['data'][0]['garudainlatitude'].toString();
        widget.glong = jsonResponse['data'][0]['garudainlongitude'].toString();
        widget.slat = jsonResponse['data'][0]['school_lat'].toString();
        widget.slong = jsonResponse['data'][0]['school_long'].toString();
      });
      Future.delayed(Duration(milliseconds: 100),(){
        return getPolyPoints();
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    getGaurdianDetail();
   //   LatLng sourceLocation = LatLng(widget.position!.latitude, widget.position!.longitude);
    print("hello here now ${widget.glat}");
    return Scaffold(
      body: widget.glat == null ? Center(child: Text("Loading..."),) : GoogleMap(
        initialCameraPosition:  CameraPosition(
          target: LatLng(double.parse(widget.glat!), double.parse(widget.glong!)),
          zoom: 13.5,
        ),
        markers: {
           Marker(
            markerId: MarkerId("source"),
            position: LatLng(double.parse(widget.glat!), double.parse(widget.glong!)),
               icon: homeIcon == null ? BitmapDescriptor.defaultMarker : homeIcon
          ),
           Marker(
            markerId: MarkerId("destination"),
            position:  LatLng(double.parse(widget.slat!), double.parse(widget.slong!)),
            // icon: BitmapDescriptor.fromAssetImage(configuration, assetName)
             icon: schoolIcon == null ? BitmapDescriptor.defaultMarker : schoolIcon
          ),
          Marker(
              markerId: MarkerId("driver"),
              position:  LatLng(double.parse(widget.dlat!), double.parse(widget.dlong!)),
              // icon: BitmapDescriptor.fromAssetImage(configuration, assetName)
              icon: driverIcon == null ? BitmapDescriptor.defaultMarker : driverIcon
          ),
        },
        polylines: {
          Polyline(
            polylineId:  PolylineId("route"),
            points: polylineCoordinates,
            color: Color(0xFF7B61FF),
            width: 6,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }
}
