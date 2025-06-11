class Platform{
  float x,y,b,h;
  Platform(float xr, float yr, float br, float hr){
    x = xr;
    y = yr;
    b = br;
    h = hr;
  }
  void display() {
    fill(#58470A);
    noStroke();
    rect(x,y, b,h);
  }
  
  boolean checkCollision(float cx, float cy, float r, float vy) {
    // Nur Kollision von oben beachten (simpler Bodencheck)
    boolean withinX = cx + r > x && cx - r < x + b;
    boolean falling = vy >= 0;
    boolean touching = cy + r >= y && cy + r <= y + h;

    return withinX && falling && touching;
  }
}
