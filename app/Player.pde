class Player {
  float x, y; 
  int lives; 
  PImage image; 
  float speed; 
  ArrayList<Attack> attacks;
  int attackCooldown = 300; // 攻撃間隔 (ms)
  long lastAttackTime = 0;

  Player(float startX, float startY) {
    x = startX;
    y = startY;
    lives = 3; // 初期残機（留年数）
    image = loadImage("player.png"); // プレイヤー画像を読み込む
    speed = 5; // [cite: 64]
    attacks = new ArrayList<Attack>();
  }

  void update() {
    // プレイヤーの攻撃を更新
    for (int i = attacks.size() - 1; i >= 0; i--) {
      Attack attack = attacks.get(i);
      attack.move(); // [cite: 77]
      if (attack.y < 0) { // 画面外に出たら削除
        attacks.remove(i);
      }
    }
  }

  void move(int direction) {
    if (direction == 0) { // 上
      y -= speed;
    } else if (direction == 1) { // 下
      y += speed;
    } else if (direction == 2) { // 左
      x -= speed;
    } else if (direction == 3) { // 右
      x += speed;
    }
    // 画面内に留める
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  void shoot() { 
    if (millis() - lastAttackTime > attackCooldown) {
      attacks.add(new Attack(x, y, -10, "player", loadImage("player_bullet.png"))); // 上向きに発射
      lastAttackTime = millis();
    }
  }

  void draw() { 
    image(image, x - image.width / 2, y - image.height / 2);
  }

  void hit() { 
    lives--; 
    println("Player hit! Lives: " + lives);
  }
}
