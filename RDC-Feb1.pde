class Particula{  
  PVector p;
  float t;
  float r,g,b;
  PVector v;
  float dr;
  
  Particula(){
    p = new PVector(random(width),random(height));
    v = PVector.random2D().mult(random(1,2));
    t = random(50,100);
    r = random(-100,100);
    g = random(-100,100);
    b = random(-100,100);
    dr = random(-0.05,0.05);
  }
  
  void display(){
    int xi = floor(p.x);
    int yi = floor(p.y);
    int ti = floor(t/2);
    
    for( int i = xi-ti<0? 0:xi-ti; i<xi+t && i<width ; i++){
      for(int j = yi-ti<0? 0:yi-ti; j<yi+t && j<height; j++){
        int pos = i+j*width;
        float dist = dist(p.x,p.y,i,j);
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
    p.add(v);
    v.rotate(dr);
    if(p.x<0|| p.x>width){
      v.x *= -1;
    }
    if(p.y<0|| p.y>height){
      v.y *= -1;
    }
  }  
}

ArrayList <Particula> particulas;
PImage imagen;
PGraphics pg;

void setup(){
  size(450,450);
  particulas = new ArrayList <Particula> ();
  for(int i = 0; i<100; i++){
    particulas.add(new Particula());
  }
  imagen = loadImage("gatocubrebocas.png");
  pg = createGraphics(450,450);
}




void draw(){
  
  image(imagen,0,0);
  
  loadPixels();
  
  //for(int i = 0; i<pixels.length; i++){
  //  pixels[i] = color(0);
  //}
  
  for(Particula p:particulas){
    p.display();
    p.mover();
  }  
  updatePixels();
  
  pg.beginDraw();
  
  for(int i = 100; i <250; i++){
    for(int j = 100; j<250; j++){
      color c =imagen.get(i,j);
      pg.stroke(c);
      pg.point(i,j);
    }
  }  
  pg.endDraw();
  
  
  
}

void keyPressed(){
  pg.save("gato.png");
}
