import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as sky;

void main() {
  runApp(new DrawPathWidget()); //new GameTest());
}

class DrawPathWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new DrawPathObject();
  }
}

class DrawPathObject extends RenderBox {
  void paint(PaintingContext context, Offset offset) {
    context.canvas.scale(2.5, 2.5);
    //context.canvas.save();
    context.canvas.rotate(3.14/8);
    //context.canvas.clipRect(new Rect.fromLTWH(0.0, 0.0, 100.0, 100.0));

    clipWithStroke(context, offset, 2.0);
    //Rect r = new Rect.fromLTWH(0.0, 0.0, 500.0, 500.0);
    //lipWithStroke(context, offset, 1.0);
    context.canvas.translate(50.0, 50.0);
    paintWithStroke(context, offset);
    //context.canvas.restore();
    //context.canvas.clipRect(r);

    context.canvas.translate(50.0, 0.0);
    //paintWithLinearGradient(context, offset);

    paintWithFill(context, offset);
  }
  void paintWithFill(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    p.style = sky.PaintingStyle.fill;
    p.color = new Color.fromARGB(0xaa, 0xff, 0xaa, 0xaa);

    Path path = new Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(40.0, 10.0);
    path.lineTo(50.0, 60.0);

    path.lineTo(10.0, 50.0);
    path.lineTo(0.0, 0.0);
    path.moveTo(10.0, 10.0);
    path.lineTo(20.0, 40.0);
    path.lineTo(40.0, 50.0);
    path.lineTo(30.0, 20.0);
    path.close();
    context.canvas.drawPath(path, p);
  }

  void paintWithStroke(PaintingContext context, Offset offset) {
    Paint p = new Paint();
    p.strokeWidth = 2.0;
    p.style = sky.PaintingStyle.stroke;
    p.filterQuality = sky.FilterQuality.high;
    //    p.colorFilter =new ColorFilter.mode(color, transferMode)
    p.strokeCap = sky.StrokeCap.butt;
    Path path = new Path();
    path.shift(new Offset(50.0, 50.0));
    path.moveTo(0.0, 0.0);
    path.lineTo(10.0, 50.0);
    path.lineTo(50.0, 60.0);
    path.lineTo(40.0, 10.0);
    path.close();
    p.color = new Color.fromARGB(0xaa, 0xaa, 0xff, 0xff);
    context.canvas.drawPath(path, p);
  }

  void clipWithStroke(PaintingContext context, Offset offset, double v) {
    Paint p = new Paint();
    p.strokeWidth = 2.0;
    p.style = sky.PaintingStyle.stroke;
    p.filterQuality = sky.FilterQuality.high;
    //    p.colorFilter =new ColorFilter.mode(color, transferMode)
    p.strokeCap = sky.StrokeCap.butt;
    Path path = new Path();
    path.shift(new Offset(50.0, 50.0));
    path.moveTo(0.0, 0.0);
    path.lineTo(0.0, 100.0*v);
    path.lineTo(100.0*v, 100.0*v);
    path.lineTo(100.0*v, 0.0);
    path.close();
    p.color = new Color.fromARGB(0xaa, 0xaa, 0xff, 0xff);
    context.canvas.clipPath(path);
  }

}
