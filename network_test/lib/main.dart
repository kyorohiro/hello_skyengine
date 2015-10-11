import 'package:flutter/widgets.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter/painting.dart';
//import 'dart:ui' as sky;
//import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mojo_services/mojo/network_service.mojom.dart';
import 'package:mojo_services/mojo/host_resolver.mojom.dart';
import 'package:flutter/src/services/fetch.dart';
import 'package:mojo/core.dart';
import 'package:mojo_services/mojo/tcp_bound_socket.mojom.dart';
import 'package:mojo_services/mojo/udp_socket.mojom.dart';
import 'package:mojo_services/mojo/net_address.mojom.dart';
import 'dart:async';
import 'package:mojo_services/mojo/url_loader.mojom.dart';
import 'package:mojo/mojo/url_request.mojom.dart';
import 'package:flutter/src/services/keyboard.dart';
import 'package:flutter/src/services/shell.dart';

NetAddress createNetAddress(List<int> addr, int port) {
  NetAddress netAddress = new NetAddress();
  netAddress.family = NetAddressFamily.IPV4;
  netAddress.ipv4 = new NetAddressIPv4();
  netAddress.ipv4.addr = new List<int>.from(addr);
  netAddress.ipv4.port = port;
  return netAddress;
}

void main() {
  Text t = new Text("Hello World");
  Center c= new Center (child: t);
  runApp(c);
  a();
}
a() async {
print("----------[101-2b]------------");
try {
  print("----------[101-2]------------");
  NetworkServiceProxy networkService = new NetworkServiceProxy.unbound();
  shell.requestService("mojo:authenticated_network_service", networkService);
  NetAddress localAddress = createNetAddress([127, 0, 0, 1], 38080);
  TcpBoundSocketProxy boundSocket = new TcpBoundSocketProxy.unbound();
  print("----------[101-2bb]------------");
  NetworkServiceCreateTcpBoundSocketResponseParams params = await networkService.ptr.createTcpBoundSocket(localAddress, boundSocket);

//  boundSocket.ptr.startListening(server);
  print("----------[101-2cb]----${params}--------");
  //networkService.close();
} catch(e) {
print("----------[101-2a]--${e}----------");
}
print("----------[101-2b]------------");
/*
  try {
    NetworkServiceProxy networkService = new NetworkServiceProxy.unbound();
    shell.requestService("mojo:authenticated_network_service", networkService);
    NetAddress localAddress = createNetAddress([0, 0, 0, 0], 0);
    TcpBoundSocketProxy boundSocket = new TcpBoundSocketProxy.unbound();
    MojoDataPipe endDataPipe = new MojoDataPipe();
    MojoDataPipe receiveDataPipe = new MojoDataPipe();
    print("----------[001-2]------------");
    await networkService.ptr.createTcpBoundSocket(localAddress, boundSocket);
    print("----------[001-1]------------");
    await networkService.close();
    print("----------[002]------------a");
  } catch(e) {
    print("----------[002]------------b");
  }*/
  /*
  UdpSocketProxy udpSocket2 = new UdpSocketProxy.unbound();
  {
    NetAddress localAddress = createNetAddress([0, 0, 0, 0], 18001);
    TcpBoundSocketProxy boundSocket = new TcpBoundSocketProxy.unbound();
    Completer c = new Completer();
    networkService.ptr.createUdpSocket(udpSocket2);
  //  UdpSocketBindResponseParams response = await udpSocket2.ptr.bind(localAddress);
}*/
  print("----------[003]------------");
}
