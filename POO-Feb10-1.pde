float x;
float y;
float t;

void setup(){
  size(500,500);
  background(255);
  x = 0;
  y = 0;
  t = 150;
}

void draw(){
  rombo(width/2,height/2,t);
  rombo(width/2+150,height/2,t);
}

void rombo(float x_, float y_, float t_){
  pushMatrix();
  translate(x_,y_);
  rotate(QUARTER_PI);
  rectMode(CENTER);
  rect(0,0,t_,t_);
  printMatrix();
  popMatrix();  
}
