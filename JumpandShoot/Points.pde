class Point {
  float x,y;
  Point(float px, float py){
    x = px;
    y = py;
  }
  int size = 25;
  void display() {
    stroke(#FFD115);
    strokeWeight(size);
    point(x,y); 
  }
  
}
