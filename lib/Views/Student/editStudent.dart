import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:job_dekho_app/Model/studentModel.dart';
import '../../Utils/ApiModel/SignUpModel.dart';
import '../../Utils/api_path.dart';

import '../../Utils/color.dart';

class EditStudent extends StatefulWidget {
  Data? studentModel;
  String? planId;
  EditStudent({this.studentModel, this.planId});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {

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



  updateStudent() async {
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
      'driver_id': widget.studentModel!.driverId.toString(),
      'school_id': widget.studentModel!.schoolId.toString(),
      'relation': parentrelationController.text,
      'occupation': parentOccupation.text,
      'sex': gender.toString(),
      'parent_id': widget.studentModel!.parentId.toString(),
      'birth_no': addharController.text,
      'roll_no':rollNoController.text,
      'blood':bloodGroupController.text,
      'division': divisionController.text,
      'emergency_no': emergencyController.text,
      'plan_id': widget.planId.toString(),
      'student_id': widget.studentModel!.studentId.toString()
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
      //Fluttertoast.showToast(msg: "${jsonResponse.message}");
      Navigator.pop(context,true);
    }
    else {
      // Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentnameController.text = widget.studentModel!.username.toString();
    ageController.text = widget.studentModel!.age.toString();
    parentOccupation.text = widget.studentModel!.occupation.toString();
    dateOfBirth  = widget.studentModel!.dob.toString();
    classController.text = widget.studentModel!.addClass.toString();
    parentrelationController.text = widget.studentModel!.relation.toString();
    addharController.text = widget.studentModel!.birthNo.toString();
    rollNoController.text = widget.studentModel!.rollNo.toString();
    gender = widget.studentModel!.sex.toString();
    bloodGroupController.text = widget.studentModel!.blood.toString();
    divisionController.text = widget.studentModel!.division.toString();
    emergencyController.text = widget.studentModel!.emergencyNo.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("Edit Student", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white,fontFamily: 'Serif')),
      ),
      body:  ListView(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
      //  crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                lastDate: DateTime(2100),
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

          InkWell(
            onTap: (){
              updateStudent();
            },
            child: Container(
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryColor
              ),
              child: Text("Update Student",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
            ),
          ),
        ],
      ),
    );
  }
}
