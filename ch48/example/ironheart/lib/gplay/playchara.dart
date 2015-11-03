part of gplay;

class PlayChara extends TinyDisplayObject {
  Game game;
  TinyImage img = null;
  GameTargetSource target;

  PlayChara(this.game, this.target, {iconSrc:"assets/ch_iron.png"}) {
    game.f.loadImage(iconSrc).then((TinyImage i) {
      img = i;
    });
  }

  void onPaint(TinyStage stage, TinyCanvas canvas) {
    TinyRect src = new TinyRect(0.0, 0.0, img.w.toDouble(), img.h.toDouble());
    TinyRect dst = new TinyRect(-50.0, -50.0, 100.0, 100.0);
    TinyPaint p = new TinyPaint();
    if (img != null) {
      canvas.drawImageRect(stage, img, src, dst, p);
    }
  }

  void onTick(TinyStage stage, int timeStamp) {
    mat = new Matrix4.identity();
    mat.translate(this.target.x, this.target.y, 1.0);
    mat.rotateZ(this.target.angle);
  }

  void advance(double speed) {
    this.target.advance(speed);
  }

  void turn(double a) {
    this.target.advance(a);
  }
}
