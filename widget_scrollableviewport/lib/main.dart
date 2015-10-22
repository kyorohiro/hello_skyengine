import 'package:flutter/material.dart';

void main() {
  // ScrollDirection.vertical.both is developping now. 2015/10/20
  //https://github.com/flutter/engine/issues/888
  Widget b1 = new NetworkImage(src: "icon.jpeg", width: 300.0, height: 300.0);
  Widget b2 = new NetworkImage(src: "icon2.jpeg", width: 300.0, height: 300.0);
  Row r1 = new Row([b1, b2, b1, b2, b1, b2, b1, b2, b1]);
  Row r2 = new Row([b2, b1, b2, b1, b2, b1, b2, b1, b2]);
  Column g = new Column([r1, r2, r1, r2, r1, r2, r1, r2, r1]);
  ScrollableViewport viewPortH = new ScrollableViewport(
      child: g, scrollDirection: ScrollDirection.horizontal,
      onScroll: (double scrollOffset) {
    print("---h-${scrollOffset}--");
  });
  ScrollableViewport viewPortV = new ScrollableViewport(
      child: viewPortH, scrollDirection: ScrollDirection.vertical,
      onScroll: (double scrollOffset) {
    print("---v-${scrollOffset}--");
  });
  runApp(viewPortV);
}
