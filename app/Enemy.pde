class Enemy {
  float x, y; 
  int hp; 
  String type; 
  PImage image; 
  float direction; 
  float speed = 2;
  ArrayList<Attack> attacks;
  int shootCooldown; 
  long lastShootTime = 0;

  Enemy(float startX, float startY, String enemyType, int initialHp, String imagePath, int cooldown) {
    x = startX;
    y = startY;
    type = enemyType; 
    hp = initialHp; 
    image = loadImage(imagePath); 
    direction = 1; 
    attacks = new ArrayList<Attack>();
    shootCooldown = cooldown; 
  }

  void update() {
    move(); 
    if (millis() - lastShootTime > shootCooldown) {
      shoot(); 
      lastShootTime = millis();
    }
    // 敵の攻撃を更新
    for (int i = attacks.size() - 1; i >= 0; i--) {
      Attack attack = attacks.get(i);
      attack.move(); // [cite: 77]
      if (attack.y > height) { // 画面外に出たら削除
        attacks.remove(i);
      }
    }
  }

  void move() { 
    x += direction * speed;
    if (x < image.width / 2 || x > width - image.width / 2) {
      direction *= -1; // 壁に当たったら反転
    }
  }

  void shoot() { ]
    attacks.add(new Attack(x, y + image.height / 2, 5, "enemy", loadImage("report.png"))); // 下向きに発射
  }

  void draw() { 
    image(image, x - image.width / 2, y - image.height / 2);
  }

  boolean isHit(Attack attack) { 
    // 敵と攻撃の衝突判定
    return (attack.x > x - image.width / 2 && attack.x < x + image.width / 2 &&
      attack.y > y - image.height / 2 && attack.y < y + image.height / 2);
  }
}
