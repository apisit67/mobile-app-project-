import 'package:http/http.dart' as Http;
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class RestService {

  Future<void> showMyDialog(BuildContext context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> showTermDialogStudent(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('เงื่อนไขและข้อตกลงในการใช้บริการ'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('1.	ในกรณีการแจ้งลา สามารถยกเลิกหรือแจ้งลาได้ก่อนการเริ่มเรียนไม่น้อยกว่า 2 ชม เพื่อที่ทางสถาบันจะได้แจ้งให้กับทางติวเตอร์ประจำวิชาต่อไป', style: TextStyle(color: Colors.grey, fontSize: 13.0),),
  //               SizedBox(height: 10,),
  //               Text('2.	ในกรณีการแจ้งลา หากมีการแจ้งลาก่อนเวลาเริ่มเรียนน้อยกว่า 1 ชม ทางสถาบันจะขอทำการคิดค่าเรียนของผู้เรียนเต็มจำนวนในชั่วโมงเรียนครั้งนั้น เพื่อเป็นค่าบริการการจัดเตรียมสถานที่และเป็นค่าชดเชยให้กับทางติวเตอร์ที่ได้จัดเตรียมการสอนไว้', style: TextStyle(color: Colors.grey, fontSize: 13.0)),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('ตกลง'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> showTermDialogTeacher(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('เงื่อนไขและข้อตกลงในการใช้บริการ'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('1.	ในกรณีแจ้งการลาหยุด ต้องแจ้งให้กับทางผู้ว่าจ้างล่วงหน้าทราบก่อนอย่างน้อย 3-7 วัน เพื่อให้ผู้ว่าจ้างได้เตรียมจัดหาบุคคลอื่นเพื่อปฎิบัติหน้าที่แทน', style: TextStyle(color: Colors.grey, fontSize: 13.0),),
  //               SizedBox(height: 10,),
  //               Text('2.	ในกรณีแจ้งการลาหยุด หากผู้รับจ้างแจ้งลาล่วงหน้าน้อยกว่า 1 วัน ผู้ว่าจ้างมีสิทธิ์ที่จะหักเงินค่าชดเชยในความเสียหายนั้นคราวละ 300บาท และจะหักเพิ่มในวันที่ผู้รับจ้างมีสอนตามชั่วโมงที่ผู้รับจ้างต้องปฎิบัติหน้าที่ในวันที่ลานั้น ยกเว้น การแจ้งลาในครั้งนั้นจะเป็นกรณีเหตุฉุกเฉิน สุดวิสัย ทั้งนี้ขึ้นอยู่กับการพิจารณาของผู้ว่าจ้าง', style: TextStyle(color: Colors.grey, fontSize: 13.0)),
  //               SizedBox(height: 10,),
  //               Text('3.	ผู้รับจ้างมีหน้าที่จะต้องส่งหลักฐานการทำงานของตนเองในแต่ละวันคือใบบันทึกเวลาสอนและใบบันทึกการสอนโดยไม่สามารถจะส่งย้อนหลังได้หากผู้รับจ้างไม่ส่งหลักฐานดังกล่าวจะถือว่าผู้รับจ้างขาดงานและผู้ว่าจ้างมีสิทธิ์ที่จะไม่จ่ายค่าจ้างของวันดังกล่าวเว้นจะมีเหตุอันสมควรที่ไม่สามารถส่งได้ทันเวลาโดยให้แก่ผู้ว่าจ้างเพื่อรับทราบและทำการส่งเอกสารทั้งหมดโดยเร็วที่สุดภายในเวลา 12.00 น.ของวันถัดไป', style: TextStyle(color: Colors.grey, fontSize: 13.0),),
  //
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('ตกลง'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // // static Future<String> postAPI() async {
  // //   var url = "http://localhost:8080/users/login";
  // //   var response = await Http.post(url, body: {'username': 'student1', 'password': '123456'});
  // //   // print(response.body);
  // //   // Map map = json.decode(response.body);
  // //   // UserDao userRes = UserDao.fromJson(map);
  // //   // print("URL image = " + userRes?.name);
  // //   return response.body;
  // // }
  //
  // Future<dynamic> postAPI(String urlPath, param) async {
  //   print(param);
  //   var header = {
  //     'Content-Type': 'application/json',
  //     // 'Authorization': 'Bearer ${profile['token']}'
  //   };
  //   var url = endPoint + urlPath;
  //   print(url);
  //   var _response = await Http.post(url, headers: header, body: param);
  //   print(_response.body);
  //
  //   if (_response.statusCode == 200) {
  //     print('Request status : ${_response.statusCode}');
  //
  //     return _response.body;
  //     // ProfileModel feedback =
  //     //     ProfileModel.fromJson(convert.jsonDecode(_response.body));
  //     // Navigator.pushNamed(context, HomeScreen.id);
  //   }
  // }
  //
  // Future<dynamic> getWithAuthAPI(String urlPath) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String _profile = await prefs.getString('profile');
  //   UserModel profile;
  //   print("profile : $profile");
  //   if (_profile != null) {
  //     profile = UserModel.fromJson(convert.jsonDecode(_profile));
  //   }
  //   String token = profile.data.token;
  //   var header = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   print(token);
  //   var url = endPoint + urlPath;
  //   var _response = await Http.get(url, headers: header);
  //   print(_response.body);
  //
  //   if (_response.statusCode == 200) {
  //     print('Request status : ${_response.statusCode}');
  //
  //     return _response.body;
  //     // ProfileModel feedback =
  //     //     ProfileModel.fromJson(convert.jsonDecode(_response.body));
  //     // Navigator.pushNamed(context, HomeScreen.id);
  //   }
  // }
  //
  // Future<dynamic> postWithAuthAPI(String urlPath, param, token) async {
  //
  //   var header = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   print(token);
  //   var url = endPoint + urlPath;
  //   var _response = await Http.post(url, headers: header, body: param);
  //   print(_response.body);
  //
  //   if (_response.statusCode == 200) {
  //     print('Request status : ${_response.statusCode}');
  //
  //     return _response.body;
  //     // ProfileModel feedback =
  //     //     ProfileModel.fromJson(convert.jsonDecode(_response.body));
  //     // Navigator.pushNamed(context, HomeScreen.id);
  //   }
  // }
  //
  // Future<dynamic> putAPI(String urlPath, param, token) async {
  //   print(param);
  //   var header = {
  //     // 'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   var url = endPoint + urlPath;
  //   var _response = await Http.put(url, headers: header, body: param);
  //   print(_response.body);
  //
  //   if (_response.statusCode == 200) {
  //     print('Request status : ${_response.statusCode}');
  //
  //     return _response.body;
  //     // ProfileModel feedback =
  //     //     ProfileModel.fromJson(convert.jsonDecode(_response.body));
  //     // Navigator.pushNamed(context, HomeScreen.id);
  //   }
  // }
  // //
  // // Future<dynamic> postAPI(String urlPath, param) async {
  // // print(param);
  // //   var header = {
  // //     'Content-Type': 'application/json',
  // //     // 'Authorization': 'Bearer ${profile['token']}'
  // //   };
  // //   var url = endPoint + urlPath;
  // //   var _response = await Http.post(url, headers: header, body: param);
  // //   print(_response.body);
  // //
  // //   if (_response.statusCode == 200) {
  // //     print('Request status : ${_response.statusCode}');
  // //
  // //     await setProfile(_response.body);
  // //     // ProfileModel feedback =
  // //     //     ProfileModel.fromJson(convert.jsonDecode(_response.body));
  // //     // Navigator.pushNamed(context, HomeScreen.id);
  // //   } else {
  // //     print('Request status : ${_response.statusCode}');
  // //   }
  // // }
  //
  // Future getProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String _profile = await prefs.getString('profile');
  //   UserModel profile;
  //   print("profile : $profile");
  //   if (_profile != null) {
  //     profile = UserModel.fromJson(convert.jsonDecode(_profile));
  //   }
  //   return profile;
  // }
  //
  // Future<void> setProfile(profile) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('profile', profile).then(
  //         (value) => print('Set Profile complete $value'),
  //     onError: (error) => print('error $error'),
  //   );
  // }
  //
  // Future<void> removeProfile(context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('profile', null).then(
  //         (value) => {
  //       print('removeProfile complete'),
  //       // Navigator.pushNamed(context, MyApp()),
  //     },
  //     onError: (error) => print('error $error'),
  //   );
  // }
}