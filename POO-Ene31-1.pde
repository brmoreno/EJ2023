// DVG
float x,y,t;
float r,g,b;
float dx;
float dy;

//setup
void setup(){
  size(600,500);
  background(255);
  x = 250;
  y = 250;
  t = 70;
  r = 255;
  g = 0;
  b = 0;
  dx = 3.5;
  dy = 1;
}

//draw 
void draw(){
  background(255);
  fill(r,g,b);
  noStroke();
  ellipse(x,y,t,t);
  
  x += dx; 
  y += dy;
  
  if(x > width- t/2){
     dx *= -1; 
  }
  
  if(x < t/2){
    dx *= -1;
  } 
  
  if(y > height -t/2){
    dy *= -1;
  }
  
  if(y<t/2){
    dy*= -1;
  }
}
