PImage playerATextureLeft, playerATextureRight;
PImage playerBTextureLeft, playerBTextureRight;
PImage platformTexture;
PImage projectileTexture;
PImage backgroundTexture;
PImage playerASprungTexture, playerBSprungTexture;
PImage playerAHurtTexture, playerBHurtTexture;

float xA = 150;
float yA = -20;

float xB = 1500 - 150;
float yB = -20;

boolean aLeft = false;
boolean aRight = false;
boolean aJump = false;

boolean bLeft = false;
boolean bRight = false;
boolean bJump = false;

boolean aFacingRight = true;
boolean bFacingRight = false;

float vyA = 0;
float vyB = 0;
float gravity = 0.8;
float jumpStrength = -20;
float playerRadius = 20;

Platform[] platforms;
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

int shootCooldownA = 0;
int shootCooldownB = 0;
int cooldownTime = 20;

boolean aWasHit = false;
boolean bWasHit = false;
int aHitCooldown = 0;
int bHitCooldown = 0;
int hitDisplayTime = 15;

int playerTextureWidth = 24;
int playerTextureHeight = 24;
int projectileTextureWidth = 10;
int projectileTextureHeight = 10;
int platformTextureWidth = 200;
int platformTextureHeight = 20;

void setup() {
  size(1500, 900);

  backgroundTexture = createPlaceholder(width, height, color(200, 200, 255));
  playerATextureLeft = createPlaceholder(playerTextureWidth, playerTextureHeight, color(255, 100, 100));
  playerATextureRight = createPlaceholder(playerTextureWidth, playerTextureHeight, color(255, 150, 150));
  playerBTextureLeft = createPlaceholder(playerTextureWidth, playerTextureHeight, color(100, 100, 255));
  playerBTextureRight = createPlaceholder(playerTextureWidth, playerTextureHeight, color(150, 150, 255));
  playerASprungTexture = createPlaceholder(playerTextureWidth, playerTextureHeight, color(255, 255, 100));
  playerBSprungTexture = createPlaceholder(playerTextureWidth, playerTextureHeight, color(255, 255, 150));
  playerAHurtTexture = createPlaceholder(playerTextureWidth, playerTextureHeight, color(255, 0, 0));
  playerBHurtTexture = createPlaceholder(playerTextureWidth, playerTextureHeight, color(0, 0, 255));
  platformTexture = createPlaceholder(platformTextureWidth, platformTextureHeight, color(100, 255, 100));
  projectileTexture = createPlaceholder(projectileTextureWidth, projectileTextureHeight, color(0));

  platforms = new Platform[9];
  platforms[0] = new Platform(0, 500, platformTextureWidth, platformTextureHeight);
  platforms[1] = new Platform(width - platformTextureWidth, 500, platformTextureWidth, platformTextureHeight);
  platforms[2] = new Platform(300, 400, platformTextureWidth, platformTextureHeight);
  platforms[3] = new Platform(width - 500, 400, platformTextureWidth, platformTextureHeight);
  platforms[4] = new Platform(480, 550, platformTextureWidth, platformTextureHeight);
  platforms[5] = new Platform(width - 730, 550, platformTextureWidth, platformTextureHeight);
  platforms[6] = new Platform(100, 200, platformTextureWidth, platformTextureHeight);
  platforms[7] = new Platform(width - 300, 200, platformTextureWidth, platformTextureHeight);
  platforms[8] = new Platform(650, 200, platformTextureWidth, platformTextureHeight);
}

  //platforms = new Platform[5];
  //platforms[0] = new Platform (0,          500,  200,20);
  //platforms[1] = new Platform (width-200,  500,  200,20);
  //platforms[2] = new Platform (300,        400,  200,20);
  //platforms[3] = new Platform (width-500,  400,  200,20);
  //platforms[4] = new Platform (650,        200,  200,20);

  PImage createPlaceholder(int w, int h, color c) {
  PImage img = createImage(w, h, RGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = c;
  }
  img.updatePixels();
  return img;
}

void draw() {
  image(backgroundTexture, 0, 0, width, height);

  for (Platform p : platforms) {
    p.display();
  }

  // Spieler A Bewegung
  if (aLeft) {
    xA -= 5;
    aFacingRight = false;
  }
  if (aRight) {
    xA += 5;
    aFacingRight = true;
  }
  yA += vyA;
  boolean onGroundA = false;
  for (Platform p : platforms) {
    if (p.checkCollision(xA, yA, playerRadius, vyA)) {
      yA = p.y - playerRadius;
      vyA = 0;
      onGroundA = true;
    }
  }
  if (aJump && onGroundA) {
    vyA = jumpStrength;
  }
  if (vyA < 19) {
    vyA += gravity;
  }

  // Spieler B Bewegung
  if (bLeft) {
    xB -= 5;
    bFacingRight = false;
  }
  if (bRight) {
    xB += 5;
    bFacingRight = true;
  }
  if (vyB < 19) {
    vyB += gravity;
  }
  yB += vyB;
  boolean onGroundB = false;
  for (Platform p : platforms) {
    if (p.checkCollision(xB, yB, playerRadius, vyB)) {
      yB = p.y - playerRadius;
      vyB = 0;
      onGroundB = true;
    }
  }
  if (bJump && onGroundB) {
    vyB = jumpStrength;
  }

  // Spieler A Darstellung
  if (aHitCooldown > 0) {
    image(playerAHurtTexture, xA - 20, yA - 20, 40, 40);
    aHitCooldown--;
  } else if (!onGroundA) {
    image(playerASprungTexture, xA - 20, yA - 20, 40, 40);
  } else if (aFacingRight) {
    image(playerATextureRight, xA - 20, yA - 20, 40, 40);
  } else {
    image(playerATextureLeft, xA - 20, yA - 20, 40, 40);
  }

  // Spieler B Darstellung
  if (bHitCooldown > 0) {
    image(playerBHurtTexture, xB - 20, yB - 20, 40, 40);
    bHitCooldown--;
  } else if (!onGroundB) {
    image(playerBSprungTexture, xB - 20, yB - 20, 40, 40);
  } else if (bFacingRight) {
    image(playerBTextureRight, xB - 20, yB - 20, 40, 40);
  } else {
    image(playerBTextureLeft, xB - 20, yB - 20, 40, 40);
  }

  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile proj = projectiles.get(i);
    proj.update();
    proj.display();

    // Kollision mit Spieler A
    if (dist(proj.x, proj.y, xA, yA) < playerRadius) {
      xA += proj.speed * 5;
      aHitCooldown = hitDisplayTime;
      projectiles.remove(i);
      continue;
    }

    // Kollision mit Spieler B
    if (dist(proj.x, proj.y, xB, yB) < playerRadius) {
      xB += proj.speed * 5;
      bHitCooldown = hitDisplayTime;
      projectiles.remove(i);
      continue;
    }

    if (proj.offscreen()) {
      projectiles.remove(i);
    }
  }

  if (shootCooldownA > 0) shootCooldownA--;
  if (shootCooldownB > 0) shootCooldownB--;

  if (yA > height - 20 && yB > height - 20) {
    xA = 150;
    yA = -20;
    xB = width - 150;
    yB = -20;
  }
}

void keyPressed() {
  if (key == 'a') aLeft = true;
  if (key == 'd') aRight = true;
  if (key == 'w') aJump = true;

  if (key == 's' && shootCooldownA == 0) {
    float dir = aFacingRight ? 1 : -1;
    projectiles.add(new Projectile(xA, yA, dir));
    xA -= dir * 5;
    shootCooldownA = cooldownTime;
  }

  if (keyCode == RIGHT) bRight = true;
  if (keyCode == LEFT) bLeft = true;
  if (keyCode == UP) bJump = true;

  if (keyCode == DOWN && shootCooldownB == 0) {
    float dir = bFacingRight ? 1 : -1;
    projectiles.add(new Projectile(xB, yB, dir));
    xB -= dir * 5;
    shootCooldownB = cooldownTime;
  }
}

void keyReleased() {
  if (key == 'a') aLeft = false;
  if (key == 'd') aRight = false;
  if (key == 'w') aJump = false;

  if (keyCode == LEFT) bLeft = false;
  if (keyCode == RIGHT) bRight = false;
  if (keyCode == UP) bJump = false;
}

class Projectile {
  float x, y, speed;
  int owner;
  Projectile(float x_, float y_, float dir) {
    x = x_ + (dir > 0 ? 20 : -20); // Startpunkt leicht vom Spieler weg versetzt
    y = y_;
    speed = dir * 10;
    owner = -1; // Besitzer wird aktuell nicht verwendet
  }
  void update() {
    x += speed;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    if (speed > 0) {
      scale(1, 1);
    } else {
      scale(-1, 1);
    }
    image(projectileTexture, -5, -5, projectileTextureWidth, projectileTextureHeight);
    popMatrix();
  }
  boolean offscreen() {
    return x < 0 || x > width;
  }
}
