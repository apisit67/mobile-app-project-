import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:book_app/homePage.dart';
import 'package:book_app/addBook.dart';
import 'package:book_app/profilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_app/services/restService.dart';

class BookDetail extends StatefulWidget {
  final Function onInit;
  final Widget child;

  final bookName;
  final bookImg;

  BookDetail(
      {Key key, @required this.bookName, @required this.bookImg, this.onInit, this.child})
      : super(key: key);

  @override
  _BookDetail createState() => _BookDetail();
}

class _BookDetail extends State<BookDetail> {
  int _selectedIndex = 0;
  var images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg'];
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);

  // UserModel profile;

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
    });

    super.initState();
  }

  void _onItemTapped(int index) {
    if(index == 1){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddBook()));
    }else if(index == 0){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }else if(index == 2){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  Future _getThingsOnStartup() async {
    // RestService restService = new RestService();
    // profile = await restService.getProfile();
    // print(profile.data.user.name);
    // username..text = profile.data.user.username;
    // name..text = profile.data.user.name;
    // nickname..text = profile.data.user.nickname;
    // tel..text = profile.data.user.tel;
    // email..text = profile.data.user.email;
    // note..text = profile.data.user.note;

  }

  onClickEdit() {}

  @override
  Widget build(BuildContext context) {

    final borrowButon = Material(
      elevation: 10.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var param = convert.jsonEncode(
              {"bookName": this.widget.bookName, "bookImg": this.widget.bookImg});

          RestService restService = RestService();

          SharedPreferences prefs = await SharedPreferences.getInstance();

          String borrowBooks = await prefs.getString('borrowBooks');
          var borrowBooksList;
          if(null != borrowBooks){
            borrowBooksList = convert.jsonDecode(borrowBooks);
          }

          print(borrowBooksList);
          if(borrowBooksList != null){
            borrowBooksList.add(param);
          }else{
            var newBorrows = [];
            newBorrows.add(param);
            borrowBooksList = newBorrows;
          }
          print(borrowBooksList);

          await prefs.setString('borrowBooks', convert.jsonEncode(borrowBooksList)).then(
                (value) => print('Set BorrowBooks complete $value'),
            onError: (error) => print('error $error'),
          );

          restService.showMyDialog(context, 'ยืมสำเร็จ');

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
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomePage()));
          //     }
          //
          //   }

          // } else {
          //   restService.showMyDialog(context, res['message']);
          // }
        },
        child: Text("ยืมหนังสือ",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );

    return Scaffold(
      // drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Image.asset(
          'images/side_menu.png',
          fit: BoxFit.contain,
          height: 150,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
          IconButton(
            icon: Icon(Icons.chat),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // handle the press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              this.widget.bookImg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 450.0,
                    enlargeCenterPage: true,
                    autoPlay: false,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.8,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(this.widget.bookName,
                    textAlign: TextAlign.left,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                Text("หมวดหมู่: นิยาย",
                    textAlign: TextAlign.left,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                SizedBox(
                  height: 10,
                ),
                Text("เมื่อภรรยาสาวชาวฮ่องกงเกิดเสียชีวิตลงอย่างปริศนา ‘สมิทธิ’ สถาปนิกหนุ่มไทยจึงตัดสินใจออกเสาะหาเบาะแสที่จะนำมาซึ่งคำอธิบายต่อการจากไปของเธอ "
                    "โดยไม่รู้เลยว่าอนาคตที่รอเขาอยู่ตรงหน้าจะคละคลุ้งไปด้วยเรื่องราวอันมืดดำของอดีตที่พันธนาทั้งเขาและภรรยาเอาไว้กับโชคชะตาอันแสนเจ็บปวด",
                    textAlign: TextAlign.left,
                    style: style.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                SizedBox(
                  height: 50,
                ),
                borrowButon

              ]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
