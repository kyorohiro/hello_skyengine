# Dart:io UDP Test
https://github.com/kyorohiro/hello_skyengine/tree/master/hello

//

// 2015/10/16

//  error

```
import 'dart:io';
import 'dart:convert';
import 'dart:async';

main() async {
  //
  // 2015/10/16
  //  ANDROID: E/chromium: [ERROR:dart_error.cc(16)] Unhandled exception:ANDROID:
  //  E/chromium: SocketException: Receive failed (OS Error: Bad address, errno = 14),
  //  address = 0.0.0.0, port = 38081ANDROID: E/chromium: #0
  //  EchoServer.startServer.<startServer_async_body> (http://localhost:9888/lib/main.dart)
  EchoServer echo = new EchoServer();
  echo.startServer("0.0.0.0", 28081);
  HelloClient hello = new HelloClient();
  String te = await hello.sendHello("0.0.0.0", 28081);
  print("### ${te}");
}

class HelloClient {
  Future<String> sendHello(String address, int port) async {
    List<int> buffer = [];
    RawDatagramSocket socket = await RawDatagramSocket.bind("0.0.0.0", 0);
    InternetAddress ad = new InternetAddress(address);
    socket.send(UTF8.encode("hello!!"), ad, port);
    await for (RawSocketEvent ev in socket.asBroadcastStream()) {
      if (ev == RawSocketEvent.READ) {
        Datagram dg = socket.receive();
        if (dg != null) {
          buffer.addAll(dg.data);
          if (buffer.length >= 7) {
            break;
          }
        }
      }
    }
    socket.close();
    return UTF8.decode(buffer);
  }
}

class EchoServer {
  RawDatagramSocket socket;
  startServer(String host, int port) async {
    socket = await RawDatagramSocket.bind(host, port);
    await for (RawSocketEvent ev in socket.asBroadcastStream()) {
      if (ev == RawSocketEvent.READ) {
        try {
          Datagram dg = socket.receive();
          if (dg != null) {
            print("${dg.address} ${dg.port} ${dg.data}");
            socket.send(dg.data, dg.address, dg.port);
          }
        } catch (e) {
          print("#########${e}");
        }
      }
    }
  }

  bye() async {
    socket.close();
  }
}

```
