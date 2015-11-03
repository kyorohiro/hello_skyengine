part of glogic;

class Game {
  TinyGameBuilderForFlutter f;
  PlayScene playScene;
  StartScreen startScene;
  ProgramScree progScene;
  TinyStage stage;
  GameEnvirone environ;

  Game() {

    environ = new GameEnvirone();
    f = new TinyGameBuilderForFlutter();
    playScene = new PlayScene(this);
    startScene = new StartScreen(this);
    progScene = new ProgramScree(this);
    stage = f.createStage(new TinyGameRoot(800.0, 600.0));

    //
    environ.red();
  }


}
