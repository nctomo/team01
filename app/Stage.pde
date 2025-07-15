void setupStage() {
  float speed = 1.5 + stage * 0.5 + difficulty * 0.3;
  int hp = 5 + stage * 2 + difficulty * 3;
  int fireInterval = max(30, 90 - stage * 10 - difficulty * 5);
  int bulletSpeed = 3 + stage + difficulty;

  prof = new Enemy(WIDTH / 2, 50, speed, hp, fireInterval, bulletSpeed);
  prof.loadImages();
  prof.bullets.clear();

  timer = timeLimit;
  taList.clear();
  player.bullets.clear();

  if (stage >= 2) {
    taList.add(new TA(0, prof.pos.x, prof.pos.y, bulletSpeed, taImg));
  }
}
