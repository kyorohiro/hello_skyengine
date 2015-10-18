import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/services.dart';

main() async {
  EditableString st= new EditableString(text: "test:", onUpdated: () {});
  keyboard.show(st.stub, KeyboardType.TEXT);
}
