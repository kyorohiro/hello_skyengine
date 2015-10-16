import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {

  try {
    //
    // 2015/10/16
    //
    // begining of crash
    Text t = new Text("${await getNetworkInterface()}");
    Center c = new Center(child: t);
    runApp(c);
  } catch (e) {
    print(e);
  }
}

Future<String> getNetworkInterface() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list(
      includeLoopback: true, includeLinkLocal: true);
  StringBuffer buffer = new StringBuffer();
  for (NetworkInterface i in interfaces) {
    buffer.write("${i.addresses} ${i.name}");
  }
  return buffer.toString();
}
