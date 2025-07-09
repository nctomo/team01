class TA {
  float x, y;        
  float opacity;     
  boolean isActive;  
  PImage image;       

  TA(float x, float y, PImage img) {
    this.x = x;
    this.y = y;
    this.image = img;
    this.opacity = 255;
    this.isActive = true;
  }

  void update() {
    if (isActive) {
      fadeOut();
    }
  }

  void draw() {
    if (isActive) {
      tint(255, opacity);
      imageMode(CENTER);
      image(image, x, y);
      noTint();
    }
  }

  void fadeOut() {
    opacity -= 2;
    if (opacity <= 0) {
      isActive = false;
      opacity = 0;
    }
  }

  boolean isVisible() {
    return isActive;
  }
}
