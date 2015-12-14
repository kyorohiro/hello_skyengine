import 'package:flutter/material.dart';

void main() {
  MyBody body = new MyBody();
  //Widget statusBar = new Text("--status bar--",style:new TextStyle(fontSize:10.0));
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
      icon: 'content/add',
      size: IconSize.s24
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
    floatingActionButton:floatingActionButton//,
    //bottomSheet:statusBar
  );

  // 2015/10/26 if use IconButton's icon option, need MatrialApp?
  runApp(new MaterialApp(
      title: "Scaffold",
      routes: <String, RouteBuilder>{
        '/': (RouteArguments args) {
          return s;
        },
      }));
  //runApp(s);
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
