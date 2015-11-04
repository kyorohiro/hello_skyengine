import 'dart:html';
import 'dart:web_gl';
import 'package:ch48/tinygame.dart';
import 'package:ch48/tinygame_webgl.dart';

void main() {
  print("--------1-dart hello ( 1 )");
 // TinyGameBuilderForWebgl gl = new TinyGameBuilderForWebgl();
 // TinyStage stage = gl.createStage(new TinyGameRoot(400.0, 400.0));
 // stage.start();
  test();
  print("--------1-dart hello ( 2 ) ");
}

void test() {
  TinyWebglContext c = new TinyWebglContext();
  RenderingContext gl = c.GL;
  TinyWebglCanvas canvas = new TinyWebglCanvas(c);
  canvas.drawRect(null, new TinyRect(50.50,0.0,100.0,100.0), null);
}