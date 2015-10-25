import 'package:flutter/material.dart';

void main() {
  MyBody body = new MyBody();
  Widget statusBar = new Text("--status bar--");
  Widget toolBar = new ToolBar(
    center: new Text("center"),
    left: new Text("left"),
    right: [
      new Text("right1"),
      new Text("right2"),
      new Text("right3")],
    backgroundColor: new Color.fromARGB(0xff, 0xff, 0xaa, 0xaa)
  );
  // .package/material_design_icons/lib/icons/content/drawable-hdpi/ic_add_black_24dp.png
  Widget floatingActionButton = new FloatingActionButton(
    child: new Icon(
      type: 'content/add',
      size: 24
    ),
    backgroundColor: new Color.fromARGB(0xff, 0xaa, 0xff, 0xaa),
    onPressed: (){
      print("pressed");
      body.text += "\n hello";
      body.update();
    }
  );
  Scaffold s = new Scaffold(
    toolBar:toolBar,
    body:body,
    floatingActionButton:floatingActionButton,
    statusBar:statusBar
  );
  runApp(s);
}

class MyBody extends StatefulComponent {
  String text = "--hello--";
  State<MyBody> current = null;
  State createState() {
    current = new MyBodyState();
    return current;
  }
  update() {
    if(current != null) {
      current.setState((){});
    }
  }
}

class MyBodyState extends State<MyBody> {
  Widget build(BuildContext context) {
    return new Material(
      child: new Center(
        child: new Text(config.text)
      )
    );
  }
}
