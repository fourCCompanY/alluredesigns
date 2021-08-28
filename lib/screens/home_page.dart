import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//=================MY OWN IMPORTS=======================
import 'package:allurenew/components/app_drawer.dart';
import 'package:allurenew/components/image_carousel.dart';
import 'package:allurenew/components/horizontal_list_view.dart';
import 'package:allurenew/components/products.dart';
import 'package:allurenew/components/customize_your_design.dart';
import 'package:allurenew/components/constants.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: kHomeAppBar,
      drawer: AppDrawer(),
      body: ListView(
        children: [
          imageCarousel,
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CustomizeYourDesign(),
          ),
          HorizontalListView(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: kDefaultBorderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                  child: Text(
                    "Our Designs",
                    style: TextStyle(
                      fontSize: 38.0,
                      fontFamily: "ReemKufi",
                      color: kOurThemeColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Products(),
        ],
      ),
    );
  }
}
