float x, y, t,r,g,b ,dx;

void setup(){
  size(500,500);
  x = 200;
  y = 200;
  t = 100;
  r= 255;
  g = 0;
  b= 255;
  background(255);
  dx = 1;
}

void draw(){
  x+= dx;
  background(255);
  noStroke();
  fill(r,g,b);
  ellipse(x,y,t,t);
  
  if(x>width-t/2){
    dx*=-1;
  }
  
  if(x<t/2){
    dx*=-1;
  }
}
