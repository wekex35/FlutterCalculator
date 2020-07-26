import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Hero(
        tag: "welcome",
        child: Container(
            padding: EdgeInsets.all(16),       
             child: NeumorphicText(
        "Calculator \n ...",
        style: NeumorphicStyle(         
          depth: 5,  //customize depth here
          color: Colors.white, 
          border: NeumorphicBorder(isEnabled: true)//customize color here
        ),
        textStyle: NeumorphicTextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 70, //customize size here
          // AND others usual text style properties (fontFamily, fontWeight, ...)
        ),
    
      ),
    )))));
  }
}
