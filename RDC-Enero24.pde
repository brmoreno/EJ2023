float x = 100;
float y,w,h,r,g,b;


void setup(){
  size(400,400);
  background(0);
  blendMode(ADD);
}

void draw(){
  
  x = random(0,width);
  y = random(0,height);
  h = random(0,100);
  w = random(0,100);
  r = random(20);
  g = random(20);
  b  = random(20);
  fill(r,g,b);
  noStroke();
  rect(x,y,w,h);
}
