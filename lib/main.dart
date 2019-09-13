import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool gridActive = true;
  String winnerTag = '';
  Color winnerTagColor = Colors.yellow;
  Color refreshButtonColor = Colors.orange[700];

  List<Icon> crossCircle = [
    Icon(
      Icons.close,
      size: 90.0,
      color: Color(0xFFE25041),
    ),
    Icon(
      Icons.exposure_zero,
      size: 100.0,
      color: Color(0xFF1ABC9C),
    )
  ];

  List<Icon> displayIcon = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null
  ];

  List<Color> boxBorderColor = [
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow,
    Colors.yellow
  ];

  Icon showCrossOrZero() {
    _counter++;
    if (_counter % 2 != 0) {
      return crossCircle[0];
    } else {
      return crossCircle[1];
    }
  }

  void _clearIcons() {
    setState(() {
      winnerTag = '';
      winnerTagColor = Colors.yellow;
      refreshButtonColor = Colors.orange[700];
      _counter = 0;
      for (int i = 0; i < 9; i++) {
        displayIcon[i] = null;
        boxBorderColor[i] = Colors.yellow;
      }
      gridActive = true;
    });
  }

  void setWinnerTag(Icon displayIcon) {
    gridActive = false;
    if (displayIcon == crossCircle[0]) {
      winnerTag = 'Player X wins';
      winnerTagColor = Color(0xFFE25041);
      refreshButtonColor = Color(0xFFE25041);
    } else {
      winnerTag = 'Player 0 wins';
      winnerTagColor = Color(0xFF1ABC9C);
      refreshButtonColor = Color(0xFF1ABC9C);
    }
  }

  void checkIfFinished() {
    if (displayIcon[0] == displayIcon[1] &&
        displayIcon[1] == displayIcon[2] &&
        displayIcon[0] != null) {
      setWinnerTag(displayIcon[0]);
    } else if (displayIcon[0] == displayIcon[3] &&
        displayIcon[6] == displayIcon[3] &&
        displayIcon[0] != null) {
      setWinnerTag(displayIcon[0]);
    } else if (displayIcon[0] == displayIcon[4] &&
        displayIcon[4] == displayIcon[8] &&
        displayIcon[0] != null) {
      setWinnerTag(displayIcon[0]);
    } else if (displayIcon[1] == displayIcon[4] &&
        displayIcon[4] == displayIcon[7] &&
        displayIcon[1] != null) {
      setWinnerTag(displayIcon[1]);
    } else if (displayIcon[2] == displayIcon[4] &&
        displayIcon[4] == displayIcon[6] &&
        displayIcon[6] != null) {
      setWinnerTag(displayIcon[2]);
    } else if (displayIcon[2] == displayIcon[5] &&
        displayIcon[5] == displayIcon[8] &&
        displayIcon[2] != null) {
      setWinnerTag(displayIcon[2]);
    } else if (displayIcon[3] == displayIcon[4] &&
        displayIcon[4] == displayIcon[5] &&
        displayIcon[3] != null) {
      setWinnerTag(displayIcon[3]);
    } else if (displayIcon[6] == displayIcon[7] &&
        displayIcon[8] == displayIcon[7] &&
        displayIcon[6] != null) {
      setWinnerTag(displayIcon[6]);
    } else if (_counter == 9) {
      winnerTag = "It's a Draw";
      winnerTagColor = Colors.yellow;
      refreshButtonColor = Colors.orange[700];
    }
  }

  void _incrementCounter(int position) {
    setState(() {
      if (gridActive) {
        _counter++;
        if (_counter % 2 != 0) {
          displayIcon[position] = crossCircle[0];
          boxBorderColor[position] = Color(0xFFE25041);
        } else {
          displayIcon[position] = crossCircle[1];
          boxBorderColor[position] = Color(0xFF1ABC9C);
        }
        if (_counter >= 5) checkIfFinished();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF222A41),
        title: Center(
          child: Text(
            'Tic Tac Toe',
            style: TextStyle(
              color: Colors.orange[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15.0),
          color: Color(0xFF303B58),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                  child: Center(
                    child: Text(
                      winnerTag,
                      style: TextStyle(
                        color: winnerTagColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    padding: EdgeInsets.all(4.0),
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 4.0,
                    addRepaintBoundaries: true,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          displayIcon[0] ?? _incrementCounter(0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[0], width: 2.0),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                            ),
                          ),
                          child: Center(
                            child: displayIcon[0],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[1] ?? _incrementCounter(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[1], width: 2.0),
                          ),
                          child: Center(
                            child: displayIcon[1],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[2] ?? _incrementCounter(2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[2], width: 2.0),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Center(
                            child: displayIcon[2],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[3] ?? _incrementCounter(3);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[3], width: 2.0),
                          ),
                          child: Center(
                            child: displayIcon[3],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[4] ?? _incrementCounter(4);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[4], width: 2.0),
                          ),
                          child: Center(
                            child: displayIcon[4],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[5] ?? _incrementCounter(5);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[5], width: 2.0),
                          ),
                          child: Center(
                            child: displayIcon[5],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[6] ?? _incrementCounter(6);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[6], width: 2.0),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                            ),
                          ),
                          child: Center(
                            child: displayIcon[6],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[7] ?? _incrementCounter(7);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[7], width: 2.0),
                          ),
                          child: Center(
                            child: displayIcon[7],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          displayIcon[8] ?? _incrementCounter(8);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: boxBorderColor[8], width: 2.0),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Center(
                            child: displayIcon[8],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _clearIcons();
        },
        backgroundColor: refreshButtonColor,
        foregroundColor: Color(0xFF222A41),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
