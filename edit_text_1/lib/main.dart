import 'package:flutter/widgets.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as sky;
import 'package:flutter/services.dart';
import 'package:mojo_services/mojo/input_events.mojom.dart';

KeyboardServiceProxy pService = null;
String inputText = "";
String composingText = "";
int sCursol = 0;
int eCursol = 1;

main() async {
  await setupKeyboard();
  runApp(new DrawRectWidget());
}

setupKeyboard() async {
  //pService = new KeyboardServiceProxy.unbound();
  //await shell.connectToService(null, pService);
  //keyboard = new Keyboard(pService.ptr);
}

class DrawRectWidget extends OneChildRenderObjectWidget {
  RenderObject createRenderObject() {
    return new EditableRenderObject();
  }
}

class EditableRenderObject extends RenderBox implements KeyboardClient {
  /*EditableString keyboardClientBase =
      new EditableString(text: "test:",
      onUpdated: () {print("onUpdated()");},
      onSubmitted:(){print("onSubmitted()");});*/

  KeyboardClientStub stub;
  EditableRenderObject() {
    stub = new KeyboardClientStub.unbound()..impl = this;
  }

  @override
  bool hitTest(HitTestResult result, {Point position}) {
    result.add(new BoxHitTestEntry(this, position));
    return true;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  void handleEvent(PointerEvent event, HitTestEntry entry) {
    print("##e");
    if (event is PointerDownEvent) {
//      keyboard.service.showByRequest();
      keyboard.show(this.stub, KeyboardType.TEXT);
      keyboard.service.setText("");
      keyboard.service.setSelection(0, 0);
      //pService.ptr.showByRequest();
    }
    markNeedsPaint();
  }

  void paint(PaintingContext context, Offset offset) {
    Color textColor = const Color.fromARGB(0xaa, 0xff, 0, 0);
    PlainTextSpan textSpan = new PlainTextSpan(inputText+composingText);
    TextStyle textStyle = new TextStyle(fontSize: 50.0, color: textColor);
    StyledTextSpan testStyledSpan = new StyledTextSpan(textStyle, [textSpan]);
    TextPainter textPainter = new TextPainter(testStyledSpan);

    textPainter.maxWidth = 200.0; //constraints.maxWidth;
    textPainter.minWidth = 200.0; //constraints.minWidth;
    textPainter.minHeight = constraints.minHeight;
    textPainter.maxHeight = constraints.maxHeight;
    textPainter.layout();
    textPainter.paint(context.canvas, new sky.Offset(100.0, 100.0));
  }

  @override
  void submit(SubmitAction action) {
    try {
      print("submit ${action}");
    } catch (e) {}
    //  this.keyboardClientBase.submit(action);
    this.markNeedsPaint();
  }

  void commitCompletion(CompletionData completion) {
    print("commitCompletion");
    //this.keyboardClientBase.commitCompletion(completion);
    this.markNeedsPaint();
  }

  void commitCorrection(CorrectionData correction) {
    try {
      print("commitCorrection");
    } catch (e) {}
    //this.keyboardClientBase.commitCorrection(correction);
    this.markNeedsPaint();
  }

  void commitText(String text, int newCursorPosition) {
    try {
      print("##commitText ${text.length} ${text.codeUnits} ${newCursorPosition}");
      print("##commitText ${text} ${text == null} ${text.length} ${newCursorPosition}");
      inputText += text;
      sCursol+= text.length;
      eCursol+= text.length;
      composingText = "";
    } catch (e) {
      print("DDD ${e}");
    }
    //this.keyboardClientBase.commitText(text, newCursorPosition);
    this.markNeedsPaint();
  }

  void deleteSurroundingText(int beforeLength, int afterLength) {
    try {
      print("deleteSurroundingText ${beforeLength} ${afterLength}");
      if(inputText.length <= sCursol) {
        sCursol = inputText.length;
        eCursol = inputText.length;
        inputText = inputText.substring(0,sCursol-1);
      } else if(sCursol > 0){
        String a = inputText.substring(sCursol-1);
        String b = inputText.substring(sCursol,inputText.length);
        inputText = a+b;
      }
      sCursol--;
      eCursol--;
    } catch (e) {}
    //this.keyboardClientBase.deleteSurroundingText(beforeLength, afterLength);
    this.markNeedsPaint();
  }

  void setComposingRegion(int start, int end) {
    try {
      print("setComposingRegion ${start} ${end}");
    } catch (e) {}
    //this.keyboardClientBase.setComposingRegion(start, end);
    this.markNeedsPaint();
  }

  void setComposingText(String text, int newCursorPosition) {
    try {
      print("setComposingText ${text} ${newCursorPosition}");
      composingText = text;
    } catch (e) {}
    //this.keyboardClientBase.setComposingText(text, newCursorPosition);
    this.markNeedsPaint();
  }

  void setSelection(int start, int end) {
    try {
      print("setSelecdtion ${start} ${end}");
    } catch (e) {}
    //this.keyboardClientBase.setSelection(start, end);
    this.markNeedsPaint();
  }
}
