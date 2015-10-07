import 'package:sky/widgets.dart';
import 'package:sky/painting.dart';
import 'package:sky/rendering.dart';
import 'dart:sky' as sky;

void main() {
  runApp(new DrawRectWidget()); //new GameTest());
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new DrawRectObject();
  }
}

class DrawRectObject extends RenderBox {
  void paint(PaintingContext context, Offset offset) {
    Color textColor = const Color.fromARGB(0xaa, 0xff, 0, 0);
    PlainTextSpan textSpan = new PlainTextSpan("Hello Text!! こんにちは!!");
    TextStyle textStyle = new TextStyle(fontSize: 50.0, color: textColor);
    StyledTextSpan testStyledSpan = new StyledTextSpan(textStyle, [textSpan]);
    TextPainter textPainter = new TextPainter(testStyledSpan);

    textPainter.maxWidth = 200; //constraints.maxWidth;
    textPainter.minWidth = 200; //constraints.minWidth;
    textPainter.minHeight = constraints.minHeight;
    textPainter.maxHeight = constraints.maxHeight;
    textPainter.layout();
    textPainter.paint(context.canvas, new sky.Offset(100, 100));
  }
}
