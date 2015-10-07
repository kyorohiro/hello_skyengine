import 'package:sky/widgets.dart';
import 'package:sky/painting.dart';
import 'package:sky/rendering.dart';
import 'dart:sky' as sky;

void main() {
  runApp(new DrawRectWidget()); //new GameTest());
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    Color textColor = const Color.fromARGB(0xaa, 0xff, 0, 0);
    PlainTextSpan textSpan = new PlainTextSpan("Hello Text!! こんにちは!!");
    TextStyle textStyle = new TextStyle(fontSize: 50.0, color: textColor);
    StyledTextSpan testStyledSpan = new StyledTextSpan(textStyle, [textSpan]);
    RenderParagraph textRenderParagraph = new RenderParagraph(testStyledSpan);

    RenderBox root = new RenderBlock();
    root.add(textRenderParagraph);
    return root;
  }
}
