import 'dart:html';
import 'dart:web_gl';
import 'dart:math' as  math;
import 'package:ch48/tinygame.dart';
import 'package:ch48/tinygame_webgl.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:ironheart/glogic/glogic.dart';
void main() {
  print("--------1-dart hello ( 1 )");
  Game game = new Game(new TinyGameBuilderForWebgl());
  game.stage.start();
  game.stage.root.child.add(game.startScene);
  print("--------1-dart hello ( 2 ) ");
}
