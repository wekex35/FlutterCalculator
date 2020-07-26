import 'package:calculator/providers/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NeumorphicAppBar(
          buttonStyle: NeumorphicStyle(
            surfaceIntensity: 0.15,
            boxShape: NeumorphicBoxShape.circle(),
            shape: NeumorphicShape.concave,
            // color: _backgroundColor(context),
          ),
          centerTitle: true,
          title: Container(
            width: double.infinity,
            // padding: EdgeInsets.all(16),
            child: Neumorphic(
              padding: EdgeInsets.all(10),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,                  
                  // boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(12)),
                  depth: 8,
                  lightSource: LightSource.topLeft,
                  color: Colors.white),
              child: Center(
                child: Text(
                  "History",
                  style: TextStyle(
                    fontSize : 24
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Container(
              padding: EdgeInsets.fromLTRB( 20,0,20,20),

          width: double.infinity,

            child: Neumorphic(
              padding: EdgeInsets.all(10),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,                  
                  // boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.circular(12)),
                  depth: 8,
                  lightSource: LightSource.topLeft,
                  color: Colors.white),
                          child: Column(
          children: <Widget>[
               Flexible(
                      child: ListView(
              padding: EdgeInsets.all(10),

                        reverse: true,
                        shrinkWrap: true,
                        children:
                            context.watch<MainProvider>().calHistory.map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(e,
                              style: TextStyle(
                                fontSize : 18,
                                letterSpacing: 1.5
                              ),
                              ),
                              Divider(),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
          ],
        ),
            )));
  }
}
