import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:carousel_slider/carousel_slider.dart';

import 'package:book_app/bookDetail.dart';
import 'package:book_app/homePage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:book_app/profilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_app/services/restService.dart';
import 'package:path_provider/path_provider.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBook createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  int _selectedIndex = 1;
  var images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg'];
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 30.0);
  File _image;

  final bookName = TextEditingController();
  final bookDesc = TextEditingController();
  final picker = ImagePicker();

  // UserModel profile;

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
    });

    super.initState();
  }

  _imgFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
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
          // getting a directory path for saving
          Directory appDocDir = await getApplicationDocumentsDirectory();
          String appDocPath = appDocDir.path;

          // copy the file to a new path
          final File newImage = await this._image.copy('$appDocPath/$bookName.text');
          var param = convert.jsonEncode({
            "bookName": bookName.text,
            "bookDesc": bookDesc.text,
            "bookImg": '$appDocPath/$bookName.text'
          });

          RestService restService = RestService();

          SharedPreferences prefs = await SharedPreferences.getInstance();

          String myBooks = await prefs.getString('myBooks');
          var myBooksList;
          if (null != myBooks) {
            myBooksList = convert.jsonDecode(myBooks);
          }

          print(myBooksList);
          if (myBooksList != null) {
            myBooksList.add(param);
          } else {
            var newBooks = [];
            newBooks.add(param);
            myBooksList = newBooks;
          }
          print(myBooksList);

          await prefs
              .setString('myBooks', convert.jsonEncode(myBooksList))
              .then(
                (value) => print('Set MyBooks complete $value'),
                onError: (error) => print('error $error'),
              );

          restService.showMyDialog(context, 'เพิ่มสำเร็จ');

          Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ProfilePage()));
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
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image,
                              width: 150,
                              height: 150,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50)),
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.grey[800],
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                    controller: bookName,
                    decoration: InputDecoration(
                      hintText: 'ชื่อหนังสือ',
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                    )),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: bookDesc,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: 'คำอธิบาย',
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                    )),
                SizedBox(
                  height: 30,
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
