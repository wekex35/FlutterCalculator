import 'package:calculator/providers/main_provider.dart';
import 'package:calculator/screens/history_screen.dart';
import 'package:calculator/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxHeight;
        _calculatorDisplay() {
          return Container(
            height: height * 0.3,
            child: Neumorphic(
                padding: EdgeInsets.all(10),
                style: NeumorphicStyle(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  depth: -1 * NeumorphicTheme.of(context).current.depth,
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: ListView(
                        reverse: true,
                        shrinkWrap: true,
                        children:
                            context.watch<MainProvider>().calHistory.map((e) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(e,
                               style: TextStyle(
                                fontSize : 15,
                                letterSpacing: 1.5
                              ),),
                              Divider(),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        context.watch<MainProvider>().getCurrentText,
                        style: TextStyle(fontSize: 20,letterSpacing: 1.5),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(20),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: Colors.blue.withAlpha(100),
                          )),
                      child: Text(
                        "=" + context.watch<MainProvider>().getTotal,
                        style: TextStyle(fontSize: 22,letterSpacing: 1.5),
                      ),
                    ),
                  ],
                )),
          );
        }

        _barButton({text, color, final Function() onPressed}) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: NeumorphicButton(
              padding: EdgeInsets.all(5),
              style: NeumorphicStyle(
                surfaceIntensity: 0.15,
                shape: NeumorphicShape.flat,
                // color: _backgroundColor(context),
              ),
              onPressed: onPressed,
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: color),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: NeumorphicBackground(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Row(
                      children: <Widget>[
                        NeumorphicText(
                          "Calculator",
                          style: NeumorphicStyle(
                            depth: 4, //customize depth here
                            color: Colors.blue, //customize color here
                          ),
                          textStyle: NeumorphicTextStyle(
                            fontSize: 18, //customize size here
                          ),
                        ),
                        Spacer(),
                        _barButton(
                            text: "CR",
                            color: Colors.redAccent,
                            onPressed: () {
                              context.read<MainProvider>().clearHistory();
                            }),
                        _barButton(
                            text: "History",
                            color: Colors.blue,
                            onPressed: context
                                        .watch<MainProvider>()
                                        .calHistory
                                        .length ==
                                    0
                                ? null
                                : () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HistoryScreen()));
                                  }),
                        Container(
                          height: 20,
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: NeumorphicSwitch(
                            value: context.watch<MainProvider>().themeMode ==
                                ThemeMode.dark,
                            onChanged: (value) {
                              context.read<MainProvider>().setThemeMode(value);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  _calculatorDisplay(),
                  Expanded(
                    child: Container(
                      // padding: EdgeInsets.only(bottom: 0, left: 25, right: 25),
                      child: GridView.count(
                        childAspectRatio: 7.5 / 7,
                        crossAxisCount: 4,
                        padding: const EdgeInsets.only(left: 25, right: 25.0),
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        children: buttons.map((e) {
                          return Container(
                            margin: EdgeInsets.all(14),
                            child: NeumorphicButton(
                              style: NeumorphicStyle(
                                surfaceIntensity: 0.15,
                                boxShape: NeumorphicBoxShape.circle(),
                                shape: NeumorphicShape.concave,
                                // color: _backgroundColor(context),
                              ),
                              onPressed: () {
                                context.read<MainProvider>().setCurrent(e);
                              },
                              child: Center(
                                child: Text(
                                  e,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
