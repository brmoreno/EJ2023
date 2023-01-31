class Particula{  
  float x,y;
  float t;
  float r,g,b;
  float dx,dy;
  
  Particula(){
    x = random(width);
    y = random(height);
    t = random(50,100);
    r = random(255);
    g = random(255);
    b = random(255);
    dx = random(-2,2);
    dy = random(-2,2);
  }
  
  void display(){
    int xi = floor(x);
    int yi = floor(y);
    int ti = floor(t/2);
    
    for( int i = xi-ti<0? 0:xi-ti; i<xi+t && i<width ; i++){
      for(int j = yi-ti<0? 0:yi-ti; j<yi+t && j<height; j++){
        int pos = i+j*width;
        float dist = dist(x,y,i,j);
        if(dist<ti){
          float f = 1-dist/(t/2);
          color c = pixels[pos];
          float rl = red(c) + r*f;
          float gl = green(c) + g*f;
          float bl = blue (c) + b*f;
          pixels[pos] = color(rl,gl,bl);
        }               
      }
    }
    
  }
  
  void mover(){
    x+= dx;
    y+= dy;
    if(x<0|| x>width){
      dx *= -1;
    }
    if(y<0|| y>height){
      dy *= -1;
    }
  }  
}

ArrayList <Particula> particulas;

void setup(){
  size(500,500);
  particulas = new ArrayList <Particula> ();
  for(int i = 0; i<100; i++){
    particulas.add(new Particula());
  }
}

void draw(){
  loadPixels();
  
  for(int i = 0; i<pixels.length; i++){
    pixels[i] = color(0);
  }
  
  for(Particula p:particulas){
    p.display();
    p.mover();
  }
  
  updatePixels();
}
