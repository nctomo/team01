class Player {
  PVector pos;
  float speed = 4;
  ArrayList<Bullet> bullets = new ArrayList<>();

  Player(float x, float y) {
    pos = new PVector(x, y);
  }

  void handleMovement() {
    if (keyPressed) {
      if (keyCode == LEFT && pos.x > 15) pos.x -= speed;
      if (keyCode == RIGHT && pos.x < WIDTH - 15) pos.x += speed;
      if (keyCode == UP && pos.y > HEIGHT/2) pos.y -= speed;
      if (keyCode == DOWN && pos.y < HEIGHT - 15) pos.y += speed;
    }
  }

  void fire() {
  bullets.add(new Bullet(pos.x, pos.y - 10, 0, -5, mainBullImg));
}


  void display() {
    fill(0, 0, 255);
    ellipse(pos.x, pos.y, 30, 30);
  }
  
  void setPosition(float x, float y) {
  pos.x = x;
  pos.y = y;
}

}
