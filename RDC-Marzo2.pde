PImage fuente;

int t1;
int t2;

void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,665);
  t1 = 10;
  t2 = 50;
  for(int l = 0; l<5; l++){
  for(int i = 0; i< width; i+= t1){
    for(int j = 0; j < height; j+= t2){
      int r1 = round(random(-50,50));
      int r2 = round(random(-20,20));
      int r3 = round(random(-20,20));
      int r4 = round(random(-5,5));
      for(int k = t2+r1; k>=1; k--){
        dibujaRect(i+r2,j+r3,t1+r4,k);
      }
    }
  }
  }
}

void keyPressed(){

}

void dibujaRect(int x_, int y_, int w_, int h_){
      float r = 0;
      float g = 0;
      float b = 0;
      for (int k = 0 ; k < w_; k+=1){
        for(int l = 0; l < h_; l+=1){
          color c = fuente.get(x_+k,y_+l);
          r +=  red(c);
          g += green(c);
          b += blue(c);
        }
      }
      color c = color(r/(w_*h_),g/(w_*h_),b/(w_*h_));
      noStroke();
      fill(c);
      rect(x_,y_,w_,h_);
}
