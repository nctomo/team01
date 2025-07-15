class MainMenu {
  Button[] buttons;

  MainMenu() {
    buttons = new Button[] {
      new Button("学部卒", 200, 100, 200, 40, 1),
      new Button("修士卒", 200, 160, 200, 40, 2),
      new Button("博士卒", 200, 220, 200, 40, 3)
    };
  }

  void drawMenu() {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("難易度を選んでください", width/2, 40);
    for (Button b : buttons) {
      b.display();
    }
  }

  void checkClick(float mx, float my) {
    for (Button b : buttons) {
      if (b.isHovered(mx, my)) {
        difficulty = b.difficultyLevel;
        resetGame();
        scene = "game";
      }
    }
  }
}
