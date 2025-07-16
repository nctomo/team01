class Enemy {
  PVector pos;
  float speed;
  int hp;
  int maxHP;
  int fireInterval;
  int bulletSpeed;
  int direction = 1;

  ArrayList<Bullet> bullets = new ArrayList<>();
  PImage enemyImg;
  PImage enemyBulletImg;

  Enemy(float x, float y, float speed, int hp, int fireInterval, int bulletSpeed) {
    pos = new PVector(x, y);
    this.speed = speed;
    this.hp = hp;
    this.maxHP = hp;
    this.fireInterval = fireInterval;
    this.bulletSpeed = bulletSpeed;
  }

  void loadImages() {
    enemyBulletImg = loadImage("enemy_bull.png");
    enemyImg = loadImage("enemy.png");
  }

  void fire() {
    if (frameCount % fireInterval == 0 && enemyBulletImg != null) {
      bullets.add(new Bullet(pos.x, pos.y + 20, 0, bulletSpeed, enemyBulletImg));
    }
  }

  void update() {
    pos.x += speed * direction;
    if (pos.x > WIDTH - 30 || pos.x < 30) direction *= -1;
  }

  void handleBullets() {
    for (int i = bullets.size() -1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.update();
      b.display();
      if (b.pos.y > HEIGHT) {
        bullets.remove(i);
      }
    }
  }

   void display() {
    if (enemyImg != null) {
      float w = enemyImg.width / 4.0; // サイズ調整（必要なら変更）
      float h = enemyImg.height / 4.0;
      image(enemyImg, pos.x - w / 2, pos.y - h / 2, w, h);
    } else {
      fill(255);
      rect(pos.x - 20, pos.y - 20, 40, 40);
      fill(0);
      textAlign(CENTER, CENTER);
      text(getLabel(), pos.x, pos.y);
    }
  }

  String getLabel() {
    switch(stage) {
      case 1: return "必修";
      case 2: return "選択必修";
      case 3: return "選択";
      case 4: return "卒研";
      default: return "？";
    }
  }

  boolean isHit(Bullet b) {
    return dist(b.pos.x, b.pos.y, pos.x, pos.y) < 20;
  }

  void damage() {
    hp--;
  }

  boolean isDead() {
    return hp <= 0;
  }
}
