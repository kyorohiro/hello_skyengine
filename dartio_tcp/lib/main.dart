import 'package:flutter/widgets.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  EchoServer echo = new EchoServer();
  echo.startServer("0.0.0.0", 28080);

  HelloClient hello = new HelloClient();
  String te = await hello.sendHello("0.0.0.0", 28080);

  Text t = new Text("#${te}#");
  Center c = new Center(child: t);
  runApp(c);
}

class HelloClient {
  Future<String> sendHello(String address, int port) async {
    Socket socket = await Socket.connect(address, port);
    socket.add(UTF8.encode("hello!!"));
    List<int> buffer = [];
    await for (List<int> v in socket.asBroadcastStream()) {
      buffer.addAll(v);
      if (buffer.length >= 7) {
        break;
      }
    }

    return UTF8.decode(buffer);
  }
}

class EchoServer {
  ServerSocket server = null;
  startServer(String address, int port) async {
    server = await ServerSocket.bind(address, port);
    server.listen((Socket socket) async {
      await for (List<int> d in socket.asBroadcastStream()) {
        socket.add(d);
      }
      socket.close();
    });
  }

  bye() async {
    server.close();
  }
}
