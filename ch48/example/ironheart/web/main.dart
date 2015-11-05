import 'dart:html';
import 'dart:web_gl';
import 'dart:math' as  math;
import 'package:ch48/tinygame.dart';
import 'package:ch48/tinygame_webgl.dart';
import 'package:vector_math/vector_math_64.dart';
import '../lib/glogic/glogic.dart';

void main() {
  print("--------1-dart hello ( 1 )");
  TinyGameBuilderForWebgl builder = new TinyGameBuilderForWebgl();
  // TinyGameBuilderForWebgl gl = new TinyGameBuilderForWebgl();
  // TinyStage stage = gl.createStage(new TinyGameRoot(400.0, 400.0));
  // stage.start();
  Game game = new Game(new TinyGameBuilderForWebgl());
  game.stage.start();
  game.stage.root.child.add(game.startScene);
  print("--------1-dart hello ( 2 ) ");
}
