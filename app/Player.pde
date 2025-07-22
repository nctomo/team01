class Player {
  PVector pos;
  float speed = 4;
  ArrayList<Bullet> bullets = new ArrayList<>();
  PImage img;
  int fireCooldown = 0; 
  int fireRate = 15;     

  Player(float x, float y, PImage img) {
    pos = new PVector(x, y);
    this.img = img;
  }

  void handleMovement() {
  if (leftPressed && pos.x > 15) pos.x -= speed;
  if (rightPressed && pos.x < WIDTH - 15) pos.x += speed;
  if (upPressed && pos.y > HEIGHT/2) pos.y -= speed;
  if (downPressed && pos.y < HEIGHT - 15) pos.y += speed;

  if (spacePressed) {
    fire();  // スペースキーが押されている間は攻撃
  }
  if (fireCooldown > 0) fireCooldown--;
}


  void fire() {
  if (fireCooldown == 0) {  // クールタイムが0のときだけ発射
    bullets.add(new Bullet(pos.x, pos.y - 10, 0, -5, mainBullImg));
    fireCooldown = fireRate;  // クールタイムをリセット
  }
}


  void display() {
    if (img != null) {
      float w = img.width / 4;  // プレイヤー画像の幅を調整
      float h = img.height / 4; // プレイヤー画像の高さを調整
      image(img, pos.x - w/2, pos.y - h/2, w, h);
    } else {
      fill(0, 0, 255);
      ellipse(pos.x, pos.y, 30, 30);
    }
  }
  
  void setPosition(float x, float y) {
  pos.x = x;
  pos.y = y;
}

}
