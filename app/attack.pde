class Bullet {
  PVector pos;
  float vx, vy;
  color c;
  PImage img;
  static final float SCALE = 0.25;  // 画像縮小率 1/4

  Bullet(float x, float y, float vx, float vy, color c) {
    pos = new PVector(x, y);
    this.vx = vx;
    this.vy = vy;
    this.c = c;
    this.img = null;
  }

  Bullet(float x, float y, float vx, float vy, PImage img) {
    pos = new PVector(x, y);
    this.vx = vx;
    this.vy = vy;
    this.img = img;
  }

  void update() {
    pos.x += vx;
    pos.y += vy;
  }

  void display() {
  if (img != null) {
    float scale = 0.25;  // 通常の縮小率
    if (img == mainBullImg) { 
      scale = 0.1;  // main_bullだけもっと小さく表示する
    }

    float w = img.width * scale;
    float h = img.height * scale;
    image(img, pos.x - w / 2, pos.y - h / 2, w, h);
  } else {
    fill(c);
    ellipse(pos.x, pos.y, 8, 8);
  }
}

}
