# Input Text From IME (RenderObject)

https://github.com/kyorohiro/hello_skyengine/tree/master/edit_text_1

![](screen.png)

```
import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as sky;
import 'package:flutter/services.dart';

KeyboardServiceProxy pService = null;
Keyboard keyboard = null;
EditableString st = null;
main() async {
  await setupKeyboard();
  runApp(new DrawRectWidget());
}

setupKeyboard() async {
  pService = new KeyboardServiceProxy.unbound();
  await shell.requestService(null, pService);
  st = new EditableString(text: "test:", onUpdated: () {});
  keyboard = new Keyboard(pService.ptr);
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new EditableRenderObject();
  }
}

class EditableRenderObject extends RenderBox implements KeyboardClient {
  EditableString keyboardClientBase =
      new EditableString(text: "test:", onUpdated: () {});

  KeyboardClientStub stub;
  EditableRenderObject() {
    stub = new KeyboardClientStub.unbound()..impl = this;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }
  @override
  void handleEvent(InputEvent event, HitTestEntry entry) {
    if (event is PointerInputEvent) {
      if (event.type == "pointerdown") {
        keyboard.show(this.stub, KeyboardType.TEXT);
        pService.ptr.showByRequest();
      }
      markNeedsPaint();
    }
  }

  void paint(PaintingContext context, Offset offset) {
    Color textColor = const Color.fromARGB(0xaa, 0xff, 0, 0);
    PlainTextSpan textSpan = new PlainTextSpan(this.keyboardClientBase.text);
    TextStyle textStyle = new TextStyle(fontSize: 50.0, color: textColor);
    StyledTextSpan testStyledSpan = new StyledTextSpan(textStyle, [textSpan]);
    TextPainter textPainter = new TextPainter(testStyledSpan);

    textPainter.maxWidth = 200.0; //constraints.maxWidth;
    textPainter.minWidth = 200.0; //constraints.minWidth;
    textPainter.minHeight = constraints.minHeight;
    textPainter.maxHeight = constraints.maxHeight;
    textPainter.layout();
    textPainter.paint(context.canvas, new sky.Offset(100, 100));
  }

  @override
  void submit(SubmitAction action) {
    this.keyboardClientBase.submit(action);
    this.markNeedsPaint();
  }

  void commitCompletion(CompletionData completion) {
    this.keyboardClientBase.commitCompletion(completion);
    this.markNeedsPaint();
  }

  void commitCorrection(CorrectionData correction) {
    this.keyboardClientBase.commitCorrection(correction);
    this.markNeedsPaint();
  }

  void commitText(String text, int newCursorPosition) {
    this.keyboardClientBase.commitText(text, newCursorPosition);
    this.markNeedsPaint();
  }

  void deleteSurroundingText(int beforeLength, int afterLength) {
    this.keyboardClientBase.deleteSurroundingText(beforeLength, afterLength);
    this.markNeedsPaint();
  }

  void setComposingRegion(int start, int end) {
    this.keyboardClientBase.setComposingRegion(start, end);
    this.markNeedsPaint();
  }

  void setComposingText(String text, int newCursorPosition) {
    this.keyboardClientBase.setComposingText(text, newCursorPosition);
    this.markNeedsPaint();
  }

  void setSelection(int start, int end) {
    this.keyboardClientBase.setSelection(start, end);
    this.markNeedsPaint();
  }
}
```
