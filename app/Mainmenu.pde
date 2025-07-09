class Mainmenu {
  String selectedDifficulty = "かんたん"; 
  PFont font;

  Mainmenu() {
    font = createFont("Arial", 32); // フォントを設定
  }

  void draw() { // [cite: 110]
    background(50, 50, 100); // メニュー背景
    fill(255);
    textFont(font);
    textAlign(CENTER, CENTER);
    text("目指せ大卒！シューティングゲーム", width / 2, height / 4); 

    // 難易度選択ボタン
    drawButton("かんたん", width / 2, height / 2 - 60, selectedDifficulty.equals("かんたん")); ]
    drawButton("ふつう", width / 2, height / 2, selectedDifficulty.equals("ふつう")); 
    drawButton("むずかしい", width / 2, height / 2 + 60, selectedDifficulty.equals("むずかしい")); 

    // スタートボタン
    drawButton("ゲームスタート", width / 2, height * 3 / 4, false); // [cite: 108]
  }

  void drawButton(String text, float x, float y, boolean isSelected) {
    if (isSelected) {
      fill(255, 200, 0); // 選択中の色
    } else {
      fill(150); // 通常の色
    }
    rectMode(CENTER);
    rect(x, y, 200, 40, 5); // 角丸のボタン
    fill(0);
    textSize(24);
    text(text, x, y);
  }

  String handleInput() { 
    if (mousePressed) {
      // 難易度選択の判定
      if (isMouseOverButton(width / 2, height / 2 - 60, 200, 40)) {
        selectedDifficulty = "かんたん";
      } else if (isMouseOverButton(width / 2, height / 2, 200, 40)) {
        selectedDifficulty = "ふつう";
      } else if (isMouseOverButton(width / 2, height / 2 + 60, 200, 40)) {
        selectedDifficulty = "むずかしい";
      }
      // スタートボタンの判定
      else if (isMouseOverButton(width / 2, height * 3 / 4, 200, 40)) {
        return "start_game"; // ゲーム開始を通知
      }
    }
    return "";
  }

  boolean isMouseOverButton(float x, float y, float w, float h) {
    return mouseX > x - w / 2 && mouseX < x + w / 2 &&
      mouseY > y - h / 2 && mouseY < y + h / 2;
  }
}
