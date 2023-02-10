void setup(){
  size(500,500);
  background(255);
}

void draw(){
  background(255);
  translate(width/2,height/2);
  for(int i = 0; i<500; i++){
    pushMatrix();
    rotate(TWO_PI/100*i);
    ellipse(50+i*0.5,0,20,20);
    popMatrix();
  }  
}
