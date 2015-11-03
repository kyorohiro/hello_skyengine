/*
import 'dart:html' as html;
import 'dart:web_gl' as gl;

void main() {
  var canvas = new html.CanvasElement(width: 500, height: 500);
  html.document.body.append(canvas);

  gl.RenderingContext GL = canvas.getContext3d();
  double r = 0.6;
  double g = 0.2;
  double b = 0.2;
  double a = 1.0;
  GL.clearColor(r, g, b, a);
  GL.clear(gl.RenderingContext.COLOR_BUFFER_BIT);
}
*/
import 'dart:html';
import 'package:ch48/tinygame.dart';
import 'package:ch48/tinygame_webgl.dart';

void main() {
  print("--------1-dart hello ( 1 )");
  TinyGameBuilderForWebgl gl = new TinyGameBuilderForWebgl();
  TinyStage stage = gl.createStage(new TinyGameRoot(400.0, 400.0));
  print("--------1-dart hello ( 2 ) ");
}
