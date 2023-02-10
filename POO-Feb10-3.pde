float r;
float s;

void setup(){
  size(500,500);
  r = 0;
  s = 1;
}

void draw(){
  background(255);
  pushMatrix();
  translate(mouseX,mouseY);
  rotate(r);
  scale(s);
  mario(-100,-50);
  popMatrix();
  
  if(keyPressed){
    if(key == 'a'){
      r-=0.1;      
    }
    if(key == 'd'){
      r+=0.1;     
    }
  }
}

void keyPressed(){
  if(key == 'w'){
    s+=0.1;
  }
  
  if(key == 's'){
    s-= 0.1;
  }
  s = constrain(s,0.1, 3);
}


void mario(float x, float y){
  noStroke();
  pushMatrix();
  translate(x,y);
  fill(255,0,0);
  rect(45,0,90,15);
  rect(30,15,150,15);
  rect(165,15,15,15);
  fill(140,96,18);
  rect(30,30,45,15);
  fill(245,204,135);
  rect(75,30,45,15);
  fill(0,0,0);
  rect(120,30,15,15);
  fill(245,204,135);
  rect(135,30,15,15);
  fill(140,96,18);
  rect(15,45,15,15);
  fill(245,204,135);
  rect(30,45,15,15);
  fill(140,96,18);
  rect(45,45,15,15);
  fill(245,204,135);
  rect(60,45,60,15);
  fill(0,0,0);
  rect(120,45,15,15);
  fill(245,204,135);
  rect(135,45,45,15);
  fill(140,96,18);
  rect(15,60,15,15);
  fill(245,204,135);
  rect(30,60,15,15);
  fill(140,96,18);
  rect(45,60,30,15);
  fill(245,204,135);
  rect(75,60,60,15);
  fill(0,0,0);
  rect(135,60,15,15);
  fill(245,204,135);
  rect(150,60,45,15);
  fill(140,96,18);
  rect(15,75,30,15);
  fill(245,204,135);
  rect(45,75,75,15);
  fill(0,0,0);
  rect(120,75,60,15);
  fill(245,204,135);
  rect(45,90,120,15);
  popMatrix();
}
