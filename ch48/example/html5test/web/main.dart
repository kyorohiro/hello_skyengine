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

test() async {
  
  TinyGameBuilderForWebgl builder = new TinyGameBuilderForWebgl();
  TinyImage image = await builder.loadImage("./test.jpg");

  TinyWebglContext c = new TinyWebglContext();
  RenderingContext gl = c.GL;
  TinyWebglCanvas canvas = new TinyWebglCanvas(c);
  {
  TinyPaint p = new TinyPaint();
  p.color = new TinyColor.argb(0xff, 0xff, 0xff, 0x00);
  canvas.drawRect(null, new TinyRect(50.0,50.0,100.0,100.0), p);
  p.color = new TinyColor.argb(0xff, 0x00, 0xff, 0xff);
  canvas.drawRect(null, new TinyRect(150.0, 150.0,100.0,100.0), p);
  }
  {
  TinyPaint p = new TinyPaint();
  p.color = new TinyColor.argb(0xff, 0xff, 0xff, 0x00);
 // 
  TinyRect src = new TinyRect(0.0, 0.0,image.w.toDouble(),image.h.toDouble());
  //canvas.drawRect(null, new TinyRect(250.0, 250.0, 100.0,100.0), p);
  canvas.drawImageRect(null, image, src, new TinyRect(250.0, 250.0, image.w.toDouble()/2,image.h.toDouble()/2), p);
  }
}