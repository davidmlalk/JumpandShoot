float r1 = random(255);
float g1 = random(255);
float b1 = random(255);

float r2 = random(255);
float g2 = random(255);
float b2 = random(255);


float xA = 150;                                                     //Koordinaten playerA am Anfang
float yA = -20;

float xB = 1500-150;                                                //Koordinaten playerB am Anfang
float yB = -20;

boolean aLeft = false;                                              //Bewegung von playerA grundsätzlich auf 0
boolean aRight = false;
boolean aJump = false;

boolean bLeft = false;                                              //Bewegung von playerB grundsätzlich auf 0
boolean bRight = false;
boolean bJump = false;

float vyA = 0;                                                      // vertikale Geschwindigkeit
float vyB = 0;
float gravity = 0.8;                                                // Schwerkraft
float jumpStrength = -20;                                           // Sprungkraft
float playerRadius = 20;                                            // Radius Player

Platform [] platforms;
// Point[] points;


//SETUP
void setup() {
  size (1500, 900);
  ////HIER KÖNNEN VERSCHIEDENE SPIELFELDER EIN- UND AUKOMMENTIERT WERDEN
  //platforms = new Platform[5];
  //platforms[0] = new Platform (0,          500,  200,20);
  //platforms[1] = new Platform (width-200,  500,  200,20);
  //platforms[2] = new Platform (300,        400,  200,20);
  //platforms[3] = new Platform (width-500,  400,  200,20);
  //platforms[4] = new Platform (650,        200,  200,20);
  
  ////platforms = new Platform[9];
  ////platforms[0] = new Platform (0,          500,  200,20);
  ////platforms[1] = new Platform (width-200,  500,  200,20);
  ////platforms[2] = new Platform (300,        400,  200,20);
  ////platforms[3] = new Platform (width-500,  400,  200,20);
  ////platforms[4] = new Platform (480,        550,  200,20);
  ////platforms[5] = new Platform (width-730,  550,  200,20);
  ////platforms[6] = new Platform (100,        200,  200,20);
  ////platforms[7] = new Platform (width-300,  200,  200,20);
  //platforms[8] = new Platform (650,        200,  200,20);
  
  platforms = new Platform[5];
  platforms[0] = new Platform (0,          500,  200,20);
  platforms[1] = new Platform (width-200,  500,  200,20);
  platforms[2] = new Platform (650,        500,  200,20); 
  platforms[3] = new Platform (375,        270,  200,20);
  platforms[4] = new Platform (width-557,  270,  200,20);
  
  
  //points = new Point[1];
  //points[0] = new Point (platform[random(platforms.length)].x+20, random(500));
  
}
//ENDE SETUP



void playerA(float xA,float yA) {                                   //xA,yA sind Koordinaten von playerA
  fill (r1,g1,b1);
  noStroke();
  circle (xA,yA, 40);
}

void playerB(float xB, float yB) {
  fill(r2,g2,b2);
  noStroke();
  circle(xB,yB, 40);
}



//DRAW
void draw() {   
  background (#5FB6FF);
  
  for(int i = 0; i < platforms.length; i++){                        //zeichne platforms
    platforms[i].display();
  }
  
  //for(int i = 0; i < points.length; i++) {
  //  points[i].display(); 
  //}
  
//BEWEGUNG & SPRUNG A
//rechts, links
  if (aLeft) xA-=5;                                                 
  if (aRight) xA+=5;
  
  yA += vyA;
  
  boolean onGroundA = false;
  for (Platform p : platforms) {
    if (p.checkCollision(xA, yA, playerRadius, vyA)) {
      yA = p.y - playerRadius;                                                 // Position Spieler auf Plattform
      vyA = 0;
      onGroundA = true;
    }
  }
  if (aJump && onGroundA) {
    vyA = jumpStrength;
  }
  if(vyA < 19) {
    vyA += gravity;
  }
  
  
//BEWEGUNG & SPRUNG B 
  if (bLeft) xB -= 5;
  if (bRight) xB += 5;
  
  if(vyB < 19) {
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

  

  playerA (xA,yA);                                                  //playerA (rot) wird gesetzt
  playerB (xB,yB);
  
  if(yA > height-20 && yB > height-20) {                            //wenn beide herunterfallen, wird neu gestartet
    xA = 150;
    yA = -20;
    xB = width-150;
    yB = -20;
    
    r1 = random(255);
    g1 = random(255);
    b1 = random(255);
    
    r2 = random(255);
    g2 = random(255);
    b2 = random(255);
  }
  
  
}
//ENDE DRAW



/////BEWEGUNGEN/////
void keyPressed() {                                                 //wenn aLeft/ aRight zutrifft (wenn Taste gedrückt wird) bewegt sich der player 
  if (key=='a'){
    aLeft = true;
  }
  
  if (key=='d'){                                                    //wenn a gedrückt, wird xA um 5 kleiner  ////PLAYER A bewegt sich nach links
    aRight =true;
  }
  
  if (key=='w'){
  aJump=true; 
  }

  if (keyCode==RIGHT){                                              //wenn 6 gedrückt, wird xB um 5 größer  ////PLAYER B nach rechts
    bRight = true;
  }
  
  if (keyCode==LEFT){                                               //wenn 4 gedrückt, wird xB um 5 kleiner    ////PLAYER B nach links   
    bLeft =true;
  }
  
  if (keyCode==UP){
    bJump=true; 
  }
}
  
  
 void keyReleased (){
   if (key== 'a') aLeft= false;                                     // Stoppen der Bewegung bei Loslassen der Taste
   if (key== 'd') aRight = false;
   if (key== 'w') aJump = false;
   
   if (keyCode== LEFT) bLeft = false;
   if (keyCode== RIGHT) bRight = false;
   if (keyCode== UP) bJump = false;
 }
 
 
 
 
 
 
 
 
 
 
 //    -->   https://www.youtube.com/watch?v=p0ZPWOaNbFw  <--
