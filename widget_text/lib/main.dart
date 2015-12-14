import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

void main() {
  Color color = new Color.fromARGB(0xff, 0xaa, 0xaa, 0xff);
  String fontFamily = "monospace";
  double fontSize = 45.0;
  ui.FontWeight fontWeight = ui.FontWeight.w900;
  ui.FontStyle fontStyle = ui.FontStyle.italic;
  ui.TextAlign textAlign = ui.TextAlign.right;
  ui.TextBaseline textBaseline = ui.TextBaseline.ideographic;

  ui.TextDecoration decoration = ui.TextDecoration.underline;
  Color decorationColor  = new Color.fromARGB(0xff, 0xff, 0xaa, 0xaa);
  ui.TextDecorationStyle decorationStyle = ui.TextDecorationStyle.double;

  TextStyle textStyle = new TextStyle(
    color: color,
    fontFamily:fontFamily,
    fontSize:fontSize,
    fontWeight:fontWeight,
    fontStyle:fontStyle,
    textAlign:textAlign,
    textBaseline:textBaseline,

    decoration:decoration,
    decorationColor:decorationColor,
    decorationStyle:decorationStyle
  );
  Text text = new Text("This is Text", style: textStyle);
  runApp(text);
}
