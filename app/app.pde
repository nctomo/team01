Player player;
ArrayList<Enemy> enemies;
ArrayList<Attack> playerAttacks;
ArrayList<Attack> enemyAttacks;
ArrayList<TA> tas;
Stage stage;
UI ui;
Mainmenu mainmenu;
Gameover gameover;
GameClear gameclear;

String scene = "menu";  // "menu", "game", "clear", "over"
int difficulty = 1;     // 1: 学部卒, 2: 修士卒, 3: 博士卒

void setup() {
  size(800, 600);
  mainmenu = new Mainmenu();
  gameover = new Gameover();
  gameclear = new GameClear();
  ui = new UI();
  frameRate(60);
}

void draw() {
  background(255);

  if (scene.equals("menu")) {
    mainmenu.draw();
  } else if (scene.equals("game")) {
    playGame();
  } else if (scene.equals("clear")) {
    gameclear.draw();
  } else if (scene.equals("over")) {
    gameover.draw();
  }
}

void playGame() {
  stage.update();
  player.move();
  player.update();
  
  for (Attack a : playerAttacks) a.move();
  for (Attack a : enemyAttacks) a.move();
  for (Enemy e : enemies) e.move();
  for (TA t : tas) t.update();

  // 当たり判定
  checkCollisions();

  stage.draw();
  for (Enemy e : enemies) e.draw();
  for (TA t : tas) t.draw();
  for (Attack a : playerAttacks) a.draw();
  for (Attack a : enemyAttacks) a.draw();
  player.draw();
  ui.draw();

  // クリア・ゲームオーバー判定
  if (stage.isCleared()) {
    scene = "clear";
  } else if (stage.isFailed() || player.lives <= 0) {
    scene = "over";
  }
}

void checkCollisions() {
  // プレイヤーの弾が敵に当たる
  for (int i = playerAttacks.size() - 1; i >= 0; i--) {
    Attack a = playerAttacks.get(i);
    for (Enemy e : enemies) {
      if (a.isColliding(e)) {
        e.hp -= 1;
        playerAttacks.remove(i);
        break;
      }
    }
  }

  // 敵の弾がプレイヤーに当たる
  for (int i = enemyAttacks.size() - 1; i >= 0; i--) {
    Attack a = enemyAttacks.get(i);
    if (a.isColliding(player)) {
      player.hit();
      enemyAttacks.remove(i);
    }
  }

  // 敵のHPが0なら削除
  for (int i = enemies.size() - 1; i >= 0; i--) {
    if (enemies.get(i).hp <= 0) enemies.remove(i);
  }
}

void keyPressed() {
  if (scene.equals("game")) {
    if (key == ' ') {
      player.shoot();
    }
    if (keyCode == UP) player.move("up");
    if (keyCode == DOWN) player.move("down");
    if (keyCode == LEFT) player.move("left");
    if (keyCode == RIGHT) player.move("right");
  }

  if (scene.equals("menu")) {
    mainmenu.handleInput(key);
  }

  if (scene.equals("clear") || scene.equals("over")) {
    if (key == 'r') startGame();
  }
}

void startGame() {
  player = new Player();
  enemies = new ArrayList<Enemy>();
  playerAttacks = new ArrayList<Attack>();
  enemyAttacks = new ArrayList<Attack>();
  tas = new ArrayList<TA>();
  stage = new Stage(difficulty);
  ui.reset();
  scene = "game";
}
