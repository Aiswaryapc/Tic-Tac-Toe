import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tic_tac_toe/utils.dart';
import 'package:velocity_x/velocity_x.dart';




class MainPage extends StatefulWidget {


  @override
  _MainPageState createState() => _MainPageState();
}

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';
}

class _MainPageState extends State<MainPage> {
  static final countMatrix = 3;
  static final double size = 92;

  String lastMove = Player.none;
  late List<List<String>> matrix;

  @override
  void initState() {
    super.initState();

    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
    countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
  ));

  Color getBackgroundColor() {
    final thisMove = lastMove == Player.X ? Player.O : Player.X;

    return getFieldColor(thisMove).withAlpha(150);
  }

  @override
  Widget build(BuildContext context) =>Container(
    color: bg,
    child: Column(
        children: [
          Container(
            color:bg,
            height: 200,
            child: Material(
              child: Container(
                color: bg,
                child: Padding(padding: EdgeInsets.only(top: 100),
                  child: Text("TIC TAC TOE",style: const TextStyle(
                      fontFamily: "Monsterrat",
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      fontStyle: FontStyle.normal),
                  ).shimmer(
                      primaryColor: Colors.white,
                      secondaryColor: Vx.red900 ,
                      duration: Duration(seconds: 3)),
                ),),
            ),

          ),

          Align(alignment: Alignment.center,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
            ),
          ),
        ]),
  );

  Widget buildRow(int x) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
        values,
            (y, value) => buildField(x, y),
      ),
    );
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.pinkAccent;
      case Player.X:
        return Colors.amber;
      default:
        return Colors.white;
    }
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getFieldColor(value);

    return Container(
      margin: EdgeInsets.all(4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(size, size),
          primary: color,
        ),
        child: Text(value, style: TextStyle(fontSize: 32)),
        onPressed: () => selectField(value, x, y),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;

      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        showEndDialog('Player $newValue Won');
      } else if (isEnd()) {
        showEndDialog('Undecided Game');
      }
    }
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  /// Check out logic here: https://stackoverflow.com/a/1058804
  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  Future showEndDialog(String title) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Vx.amber200,
      title: Text3(title),
      content: Text('Press to Restart the Game',
        style: const TextStyle(
            fontFamily: "Monsterrat",
            fontWeight: FontWeight.w900,
            fontSize: 20,
            fontStyle: FontStyle.normal),
      ).shimmer(
          primaryColor: Colors.black,
          secondaryColor: Vx.red900,
          duration: Duration(seconds: 3)),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Vx.pink900 ,
            elevation: 6,
            onPrimary: Colors.white,
            onSurface: Vx.amber300,
          ),
          onPressed: () {
            setEmptyFields();
            Navigator.of(context).pop();
          },
          child: Text2('Restart'),
        )
      ],
    ),
  );
}


const bg = Color(0xFF0c072f);

Widget Text2( text) {
  return Material(
    child: Container(
      color:Vx.pink900  ,
      child: Text(text,style: const TextStyle(
          fontFamily: "Monsterrat",
          fontWeight: FontWeight.w900,
          fontSize: 20,
          fontStyle: FontStyle.normal),
      ).shimmer(
          primaryColor: Colors.white,
          secondaryColor: Vx.pink900 ,
          duration: Duration(seconds: 3)),),
  );}




Widget Text3( text) {
  return Material(
    child: Container(
      color: Vx.amber200,
      child: Text(text,style: const TextStyle(
          fontFamily: "Monsterrat",
          fontWeight: FontWeight.w900,
          fontSize: 30,
          fontStyle: FontStyle.normal),
      ).shimmer(
          primaryColor: Colors.black,
          secondaryColor: Vx.amber500 ,
          duration: Duration(seconds: 3)),),
  );}

