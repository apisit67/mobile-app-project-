import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart' as foundation;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_app/homePage.dart';
import 'package:book_app/services/restService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: Colors.deepOrange,
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;
  TabController _tabController;
  int segmentedControlValue = 0;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final username = TextEditingController();
  final password = TextEditingController();

  final fullNameRegis = TextEditingController();
  final usernameRegis = TextEditingController();
  final passwordRegis = TextEditingController();

  String _selectedValue;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _tabController =
          new TabController(length: 2, initialIndex: _currentIndex);
    });
  }

  Widget _segmentedControl() => Container(
        width: 500,
        child: CupertinoSegmentedControl<int>(
          selectedColor: Colors.blue,
          borderColor: Colors.white,
          children: {
            0: Text('All'),
            1: Text('Recommendations'),
          },
          onValueChanged: (int val) {
            setState(() {
              segmentedControlValue = val;
            });
          },
          groupValue: segmentedControlValue,
        ),
      );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      controller: username,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: password,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final fullNameFieldRegisField = TextField(
      controller: fullNameRegis,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final usernameFieldRegisField = TextField(
      controller: usernameRegis,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordFieldRegisField = TextField(
      controller: passwordRegis,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.deepOrange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var param = convert.jsonEncode(
              {"username": username.text, "password": password.text});

          SharedPreferences prefs = await SharedPreferences.getInstance();
          String _profile = await prefs.getString('regisParam');

          var regisParam = convert.jsonDecode(_profile);

          print(regisParam);

          if (regisParam["username"] == username.text &&
              regisParam["password"] == password.text) {
            await prefs.setString('profile', param).then(
                  (value) => print('Set Profile completed $value'),
              onError: (error) => print('error $error'),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }else{
            RestService restService = RestService();
            restService.showMyDialog(context, "Email หรือ รหัสผ่าน ไม่ถูกต้อง");
          }

          // RestService restService = RestService();
          //
          // var data = await restService.postAPI("/users/login", param);
          //
          // var res = convert.jsonDecode(data);
          //
          // if (res['response_status'] == 'SUCCESS') {
          //   await restService.setProfile(data);
          //
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString('regisParam', profile).then(
          //       (value) => print('Set Profile complete $value'),
          //   onError: (error) => print('error $error'),
          // );
          //   String _profile = await prefs.getString('profile');
          //
          //   print(_profile);
          //   var isLoggedIn = false;
          //   if(_profile != null){
          //     UserModel profile;
          //     print("profile : $profile");
          //     profile = UserModel.fromJson(convert.jsonDecode(_profile));
          //     String userType = profile.data.user.userType;
          //     if(userType == "STUDENT"){
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (context) => HomePage()));
          //     }else if(userType == "TEACHER"){
          //     }
          //
          //   }

          // } else {
          //   restService.showMyDialog(context, res['message']);
          // }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final signupButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.deepOrange,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var param = convert.jsonEncode({
            "username": usernameRegis.text,
            "password": passwordRegis.text,
            "fullName": fullNameRegis.text
          });

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('regisParam', param).then(
                (value) => print('Set Register complete $value'),
                onError: (error) => print('error $error'),
              );

          RestService restService = RestService();

          restService.showMyDialog(context, 'สมัครสมาชิกสำเร็จ');

          setState(() {
            this.segmentedControlValue = 0;
          });

          // RestService restService = RestService();
          //
          // var data = await restService.postAPI("/users/login", param);
          //
          // var res = convert.jsonDecode(data);
          //
          // if (res['response_status'] == 'SUCCESS') {
          //   await restService.setProfile(data);
          //
          //   final SharedPreferences prefs = await SharedPreferences.getInstance();
          //   String _profile = await prefs.getString('profile');
          //
          //   print(_profile);
          //   var isLoggedIn = false;
          //   if(_profile != null){
          //     UserModel profile;
          //     print("profile : $profile");
          //     profile = UserModel.fromJson(convert.jsonDecode(_profile));
          //     String userType = profile.data.user.userType;
          //     if(userType == "STUDENT"){
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (context) => HomePage()));
          //     }else if(userType == "TEACHER"){
          //       Navigator.push(
          //           context, MaterialPageRoute(builder: (context) => HomeTeacherPage()));
          //     }
          //
          //   }

          // } else {
          //   restService.showMyDialog(context, res['message']);
          // }
        },
        child: Text("SIGN UP",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: new GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                      child: Image.asset(
                        "images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      width: 500,
                      child: CupertinoSegmentedControl<int>(
                        selectedColor: Colors.deepOrange,
                        borderColor: Colors.white,
                        children: {
                          0: Text('Log In'),
                          1: Text('Sign Up'),
                        },
                        onValueChanged: (int val) {
                          setState(() {
                            segmentedControlValue = val;
                          });
                        },
                        groupValue: segmentedControlValue,
                      ),
                    ),
                    segmentedControlValue == 0
                        ? Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 45.0),
                                  Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text("Email"),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  usernameField,
                                  SizedBox(height: 25.0),
                                  Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text("รหัสผ่าน"),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  passwordField,
                                  SizedBox(
                                    height: 35.0,
                                  ),
                                  loginButon,
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ]),
                          )
                        : Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 45.0),
                                  Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text("Full Name"),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  fullNameFieldRegisField,
                                  SizedBox(height: 25.0),
                                  Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text("Email"),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  usernameFieldRegisField,
                                  SizedBox(height: 25.0),
                                  Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text("รหัสผ่าน"),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 15.0),
                                  passwordFieldRegisField,
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  signupButton,
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ]),
                          ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
