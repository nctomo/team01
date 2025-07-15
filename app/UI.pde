void drawUI() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(16);
  text("残機(留年): " + lives, 10, 10);
  text("残り時間: " + timer / 60, WIDTH - 120, 10);
  text("現在: " + stage + "回生", WIDTH / 2 - 40, 10);
  if (prof != null) {
    text("教授HP: " + prof.hp + "/" + prof.maxHP, WIDTH / 2 - 40, 30);
  }
}
