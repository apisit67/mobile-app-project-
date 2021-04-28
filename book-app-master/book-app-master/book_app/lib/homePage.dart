import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:book_app/bookDetail.dart';
import 'package:book_app/addBook.dart';
import 'package:book_app/profilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _selectedIndex = 0;
  var images = ['1.jpg', '2.jpg', '3.jpg', '4.jpg'];
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 5.0);

  // UserModel profile;

  @override
  void initState() {
    this._selectedIndex = 0;
    _getThingsOnStartup().then((value) {
      print('Async done');
    });

    super.initState();
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
              padding: const EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextField(
                    decoration: InputDecoration(
                  hintText: 'ค้นหาหนังสือที่นี่',
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                )),
                SizedBox(
                  height: 10,
                ),
                Text("จากคนที่คุณติดตาม",
                    textAlign: TextAlign.left,
                    style: style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 1",
                                        bookImg:
                                            "https://yuzudigital.com/books/book001.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book001.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 2",
                                        bookImg:
                                            "https://yuzudigital.com/books/book002.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book002.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 2",
                                        bookImg:
                                            "https://yuzudigital.com/books/book003.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book003.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 4",
                                        bookImg:
                                            "https://yuzudigital.com/books/book004.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book004.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
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
                Text("ได้รับความนิยม",
                    textAlign: TextAlign.left,
                    style: style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 1",
                                        bookImg:
                                            "https://yuzudigital.com/books/book1.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book1.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 2",
                                        bookImg:
                                            "https://yuzudigital.com/books/book2.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book2.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
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
                Text("หนังสือทั้งหมด",
                    textAlign: TextAlign.left,
                    style: style.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15)),
                SizedBox(
                  height: 10,
                ),
                CarouselSlider(
                  items: [
                    //1st Image of Slider
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 6",
                                        bookImg:
                                            "https://yuzudigital.com/books/book5.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book5.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 6",
                                        bookImg:
                                            "https://yuzudigital.com/books/book6.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book6.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 7",
                                        bookImg:
                                            "https://yuzudigital.com/books/book7.jpg",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book7.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDetail(
                                        bookName: "หนังสือ 8",
                                        bookImg:
                                            "https://yuzudigital.com/books/book8.png",
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://yuzudigital.com/books/book8.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
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
                )
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
