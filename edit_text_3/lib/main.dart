import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:async';

main() async {
  EditableString st = new EditableString(text: "test:",
  onUpdated: () {},
  onSubmitted:(){});
  KeyboardHandle handle = keyboard.show(st.stub, KeyboardType.TEXT);
  await new Future.delayed(new Duration(seconds: 3));
  for (int i = 0; i < 3; i++) {
    print("----");
    st.setComposingText("a", 1);
    await new Future.delayed(new Duration(seconds: 1));
    st.setComposingText("", 0);
    await new Future.delayed(new Duration(seconds: 1));
    st.deleteSurroundingText(1, 0);
  }
}
