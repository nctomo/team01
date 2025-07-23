final int WIDTH = 600;
final int HEIGHT = 400;

String scene = "menu";
int difficulty = 1;
int stage = 1;
int maxStage = 4;

Player player;
Enemy prof;
PImage taImg;
PImage mainBullImg;
PImage playerImg;
PImage backgroundImg;

ArrayList<TA> taList = new ArrayList<>();

int lives = 3;
int timeLimit = 60 * 30;
int timer;

MainMenu mainMenu;

boolean leftPressed = false;
boolean rightPressed = false;
boolean upPressed = false;
boolean downPressed = false;
boolean spacePressed = false;


void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  size(WIDTH, HEIGHT);
  taImg = loadImage("TA.png");
  backgroundImg = loadImage("classroom.jpg");
  mainBullImg = loadImage("main_bull.png");
  playerImg = loadImage("player.png");
  PFont font = createFont("Meiryo", 20);
  textFont(font);

  player = new Player(WIDTH/2, HEIGHT - 50, playerImg);
  mainMenu = new MainMenu();
}

void resetGame() {
  stage = 1;
  lives = 3;
  player.bullets.clear();
  if (prof != null) prof.bullets.clear();
  taList.clear();
  player.setPosition(WIDTH / 2, HEIGHT - 50);
  setupStage();
}



void draw() {
  background(0);
  switch (scene) {
    case "menu": mainMenu.drawMenu(); break;
    case "game": drawGame(); break;
    case "game_over": drawGameOver(); break;
    case "clear": drawGameClear(); break;
  }
}

void drawGame() {
  image(backgroundImg, 0, 0, WIDTH, HEIGHT);
  if (timer > 0) timer--;
  else { scene = "game_over"; return; }
  
  player.handleMovement();

  prof.update();
  prof.fire();
  prof.display();
  prof.handleBullets();



  // プレイヤーの弾更新・当たり判定
  for (int i = player.bullets.size()-1; i >= 0; i--) {
    Bullet b = player.bullets.get(i);
    b.update();
    b.display();
    if (b.pos.y < 0) {
      player.bullets.remove(i);
      continue;
    }
    if (prof.isHit(b)) {
      prof.damage();
      player.bullets.remove(i);
      if (prof.isDead()) {
  stage++;
  if (stage > maxStage) {
    // 次の課程に進む
    if (maxStage == 4) {
      maxStage = 6; // 修士に進む
      stage = 5;
      setupStage();
    } else if (maxStage == 6) {
      maxStage = 8; // 博士に進む
      stage = 7;
      setupStage();
    } else {
      scene = "clear"; // 博士課程をクリア
    }
  } else {
    setupStage();
  }
}

    }
  }

  // 教授の弾でプレイヤー判定
  for (int i = prof.bullets.size()-1; i >= 0; i--) {
    Bullet b = prof.bullets.get(i);
    if (dist(b.pos.x, b.pos.y, player.pos.x, player.pos.y) < 20) {
      prof.bullets.remove(i);
      lives--;
      if (lives <= 0) {
        scene = "game_over";
        return;
      }
    }
  }

  // TAの更新と弾処理
  for (int i = taList.size()-1; i >= 0; i--) {
    TA ta = taList.get(i);
    ta.update(prof.pos.x);
    ta.display();
    ta.tryFire();

    ArrayList<Bullet> bulletsToRemove = new ArrayList<>();
    for (Bullet b : ta.bullets) {
      b.update();
      b.display();
      if (b.pos.y > HEIGHT || dist(b.pos.x, b.pos.y, player.pos.x, player.pos.y) < 20) {
        bulletsToRemove.add(b);
        if (dist(b.pos.x, b.pos.y, player.pos.x, player.pos.y) < 20) {
          lives--;
          if (lives <= 0) {
            scene = "game_over";
            return;
          }
        }
      }
    }
    ta.bullets.removeAll(bulletsToRemove);

    if (ta.opacity <= 0) {
      taList.remove(i);
    }
  }

  player.display();

  drawUI();
}

void keyPressed() {
  if (keyCode == LEFT) leftPressed = true;
  if (keyCode == RIGHT) rightPressed = true;
  if (keyCode == UP) upPressed = true;
  if (keyCode == DOWN) downPressed = true;
  if (key == ' ') spacePressed = true;
}

void keyReleased() {
  if (keyCode == LEFT) leftPressed = false;
  if (keyCode == RIGHT) rightPressed = false;
  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
  if (key == ' ') spacePressed = false;
}



void mousePressed() {
  if (scene.equals("menu")) {
    mainMenu.checkClick(mouseX, mouseY);
  }
}


// 追加でButtonクラスを入れる
class Button {
  String label;
  float x, y, w, h;
  int difficultyLevel;
  Button(String label, float x, float y, float w, float h, int level) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.difficultyLevel = level;
  }

  void display() {
    fill(isHovered(mouseX, mouseY) ? 180 : 100);
    rect(x, y, w, h);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(label, x + w/2, y + h/2);
  }

  boolean isHovered(float mx, float my) {
    return (mx > x && mx < x + w && my > y && my < y + h);
  }
}
