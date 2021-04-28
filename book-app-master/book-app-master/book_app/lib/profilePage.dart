import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:carousel_slider/carousel_slider.dart';

import 'package:book_app/addBook.dart';
import 'package:book_app/homePage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_app/services/restService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  int _selectedIndex = 2;
  var images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg'];
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);
  File _image;

  final bookName = TextEditingController();
  final bookDesc = TextEditingController();
  int segmentedControlValue = 0;

  var borrowBooks;
  var myBooks;
  var myBookSize = 0;

  // UserModel profile;

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
    });

    super.initState();
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddBook()));
    } else if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (index == 2) {
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
    RestService restService = RestService();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String gotBorrowBooks = await prefs.getString('borrowBooks');

    var json = convert.jsonDecode(gotBorrowBooks);

    String gotMyBooks = await prefs.getString('myBooks');

    var jsonMyBook = convert.jsonDecode(gotMyBooks);

    setState(() {
      this.borrowBooks = json;
      this.myBooks = jsonMyBook;
      // this.myBookSize = jsonMyBook.size();
      // print(this.borrowBooks["bookName"]);
    });
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
          // var param = convert.jsonEncode(
          //     {"username": username.text, "password": password.text});

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
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => HomePage()));
          //     }
          //
          //   }

          // } else {
          //   restService.showMyDialog(context, res['message']);
          // }
        },
        child: Text("ให้ยืม",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ),
    );

    return Scaffold(
      // drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        automaticallyImplyLeading: false,
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
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                      ),
                      radius: 50.0,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "2",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "หนังสือ",
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "13",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "ผู้ติดตาม",
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "4",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "กำลังติดตาม",
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'APS-APPTNPK-DAVE \n2000s PISCES | EN COE 28 | KKU \nชอบเพชรพระอุมามากกก',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 500,
                  child: CupertinoSegmentedControl<int>(
                    selectedColor: Colors.deepOrange,
                    borderColor: Colors.white,
                    children: {
                      0: Text('หนังสือของฉัน'),
                      1: Text('ยืม - คืนหนังสือ'),
                    },
                    onValueChanged: (int val) {
                      setState(() {
                        segmentedControlValue = val;
                      });
                    },
                    groupValue: segmentedControlValue,
                  ),
                ),
                segmentedControlValue == 1
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: borrowBooks == null ? 0 : borrowBooks.length,
                        itemBuilder: (context, index) {
                          var jsonBook = convert.jsonDecode(borrowBooks[index]);
                          print(jsonBook["bookName"]);
                          // return Text(borrowBooks[index]);
                          return Card(
                              child: ListTile(
                                  title: Text(jsonBook["bookName"]),
                                  subtitle: Text("รอคืน"),
                                  leading: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth: 44,
                                        minHeight: 100,
                                        maxWidth: 64,
                                        maxHeight: 100,
                                      ),
                                      child: new Image.network(
                                          jsonBook["bookImg"])),
                                  trailing: Wrap(
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      new IconButton(
                                        icon: new Icon(Icons.check),
                                        onPressed: () async {
                                          print(borrowBooks);
                                          RestService restService =
                                              RestService();

                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          borrowBooks.removeAt(index);
                                          print(borrowBooks);
                                          await prefs
                                              .setString(
                                                  'borrowBooks',
                                                  convert
                                                      .jsonEncode(borrowBooks))
                                              .then(
                                                (value) => print(
                                                    'Set BorrowBooks complete $value'),
                                                onError: (error) =>
                                                    print('error $error'),
                                              );

                                          restService.showMyDialog(
                                              context, 'คืนหนังสือสำเร็จ');
                                          setState(() {
                                            borrowBooks = borrowBooks;
                                          });
                                        },
                                      ),
                                      new IconButton(
                                        icon: new Icon(Icons.close),
                                        onPressed: () {
                                          /* Your code */
                                        },
                                      ),
                                    ],
                                  )));
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: myBooks == null ? 0 : myBooks.length,
                        itemBuilder: (context, index) {
                          var jsonBook = convert.jsonDecode(myBooks[index]);
                          print(jsonBook["bookName"]);
                          // return Text(borrowBooks[index]);

                          return CarouselSlider(
                            items: [
                              //1st Image of Slider
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: new DecorationImage(
                                    image: new FileImage(
                                        File(jsonBook["bookImg"])),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                            options: CarouselOptions(
                              height: 350.0,
                              enlargeCenterPage: true,
                              autoPlay: false,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.8,
                            ),
                          );
                        })
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
