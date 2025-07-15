class TA {
  int opacity;
  PVector pos;
  float speed;
  ArrayList<Bullet> bullets;
  PImage img;

  TA(int opacity, float x, float y, int bulletSpeed, PImage img) {
    this.opacity = 255;
    this.pos = new PVector(x, y);
    this.speed = 2;
    this.bullets = new ArrayList<Bullet>();
    this.img = img;
  }

  void update(float targetX) {
    if (targetX > pos.x) pos.x += speed;
    else pos.x -= speed;
    opacity -= 1;
  }

  void display() {
    if (img != null) {
      tint(255, opacity);
      image(img, pos.x - img.width/4, pos.y - img.height/4, img.width/2, img.height/2); // 縮小表示
      noTint();
    } else {
      fill(0, 255, 0, opacity);
      ellipse(pos.x, pos.y, 30, 30);
    }
  }

  void tryFire() {
    if (frameCount % 60 == 0) {
      bullets.add(new Bullet(pos.x, pos.y + 10, 0, 4, color(0, 255, 0)));
    }
  }
}
