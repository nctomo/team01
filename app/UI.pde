class UI {
  int lives;            // 残機（留年数）
  int stage;            // 今のステージ
  int timeRemaining;    // 残り時間（秒）
  String difficulty;    // 難易度（"学部卒", "修士卒", "博士卒"）

  UI(int lives, int stage, int timeRemaining, String difficulty) {
    this.lives = lives;
    this.stage = stage;
    this.timeRemaining = timeRemaining;
    this.difficulty = difficulty;
  }

  void update(int lives, int stage, int timeRemaining) {
    this.lives = lives;
    this.stage = stage;
    this.timeRemaining = timeRemaining;
  }

  void draw() {
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);

    // 残機（留年数）
    text("残機（留年）: " + lives, 20, 20);

    // ステージ（学年）
    text("ステージ: " + stage + "回生", 20, 50);

    // 残り時間
    text("残り時間: " + timeRemaining + "秒", 20, 80);

    // 難易度
    text("難易度: " + difficulty, 20, 110);
  }
}
