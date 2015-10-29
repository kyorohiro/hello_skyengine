import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

main() async {
  EditableString st= new EditableString(text: "test:", onUpdated: () {}, onSubmitted:(){});
  keyboard.show(st.stub, KeyboardType.TEXT);
}
