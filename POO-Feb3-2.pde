float d;

void setup(){
  size(500,500);
  background(255);
  
}

void draw(){
  d+= 0.01;
  for(int i = 0; i<width; i+=20){
    for(int j = 0 ;j <height; j+=20){
      
      float r = noise(i*0.01,j*0.01,d)*255;
      float g = noise(i*0.01+5,j*0.01+2,d)*255;
      float b = noise(i*0.01+4,j*0.01+1,d)*255;
      
      fill(r,g,b);
      rect(i,j,20,20);
    }
  }
}
