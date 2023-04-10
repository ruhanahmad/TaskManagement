import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF068B71);
const kPrimaryAltColor = Color(0xFF129539);
const kSecondaryColor = Color(0xFFA3CA38);
const kTertiaryColor = Color(0xFFE9B529);
const kTextColor = Color(0xFF141414);
const kBackgroundColor = Color(0xFFFFFFFF);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
// Text Style

const kBoardingTextStyle = TextStyle(
  fontSize: 24,
  color: kTextColor,
  fontWeight: FontWeight.w700,
);

const kAppBarTextStyle = TextStyle(
  fontSize: 18,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
const kTitleTextStyle = TextStyle(
  fontSize: 16,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kContentTextStyle = TextStyle(
  fontSize: 14,
  color: kTextColor,
  fontWeight: FontWeight.w600,
);

const kFormTextStyle = TextStyle(
  fontSize: 13,
  color: kTextColor,
  fontWeight: FontWeight.w600,
);

const kSmallTextStyle = TextStyle(
  fontSize: 12,
  color: kTextColor,
  fontWeight: FontWeight.w400,
);

const kExtraSmallTextstyle = TextStyle(
  fontSize: 8,
  color: kTextColor,
  fontWeight: FontWeight.w400,
);

extension CustomString on String {
  String capitalizeFirst() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

class Nav {
  static toScreen(context, Widget screen) {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return screen;
            }));
  }
}

class MyTabBar {
  final String tabText;
  MyTabBar({required this.tabText});

  // object
  //static MyTabBar tabBar = MyTabBar(tabText: '');
  static List<MyTabBar> tabs = [
    MyTabBar(tabText: 'Accounts'),
    MyTabBar(tabText: 'Cards'),
    MyTabBar(tabText: 'Stocks'),
    MyTabBar(tabText: 'Crypto'),
    MyTabBar(tabText: 'Vaults'),
  ];
}

class TabSelection {
  static int isSelected = 0;
}
// waah mera putar fair getx use karn da ki faida ?
// hehe getx bd mai lgay tha ya front end bnatywqt kia tha Get.to(); bas itna sa kaam hota hay
class MyToDoList {
  final String imagePath, description;
  final Color color;
  MyToDoList(
      {required this.color,
      required this.imagePath,
      required this.description});

  static List<MyToDoList> todoBox = [
    //sample images and description....

    MyToDoList(
      color: Colors.lightBlueAccent,
      imagePath: 'assets/images/coins.png',
      description: 'Add Money',
    ),
    MyToDoList(
      color: Colors.blueGrey,
      imagePath: 'assets/images/coins.png',
      description: 'ch you',
    ),
    MyToDoList(
      color: Colors.indigo,
      imagePath: 'assets/images/coins.png',
      description: 'reach you',
    ),
  ];
}

class MySuggestedList {
  final String imagePath, description;
  final Color color;
  MySuggestedList(
      {required this.color,
      required this.imagePath,
      required this.description});

  static List<MySuggestedList> suggestedBox = [
    //sample images and description....

    MySuggestedList(
      color: Colors.pinkAccent,
      imagePath: 'assets/images/coins.png',
      description: 'Can we reach you?',
    ),
    MySuggestedList(
      color: Colors.grey,
      imagePath: 'assets/images/coins.png',
      description: 'Add Money',
    ),
    MySuggestedList(
      color: Colors.deepOrange,
      imagePath: 'assets/images/coins.png',
      description: 'can we reach you',
    ),
    MySuggestedList(
      color: Colors.deepPurpleAccent,
      imagePath: 'assets/images/coins.png',
      description: 'can we reach you',
    ),
  ];
}

Color scaffoldColor = Colors.white70.withOpacity(0.9);
double kTitleSize = 35.0;

class ColorList {
  final Color color;
  ColorList({
    required this.color,
  });

  static List<ColorList> colorList = [
    //sample Colors....

    ColorList(
      color: Colors.pinkAccent,
    ),
    ColorList(
      color: Colors.grey,
    ),
    ColorList(
      color: Colors.deepOrange,
    ),
    ColorList(
      color: Colors.deepPurpleAccent,
    ),
    ColorList(
      color: Colors.lightBlueAccent,
    ),
  ];
}
