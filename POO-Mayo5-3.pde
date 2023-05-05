ArrayList <Particula> particulas;
import processing.video.*;
Capture camara;

void setup(){
  size(500,500);
  String[] cameras = Capture.list();

  camara = new Capture(this, cameras[0]);
  camara.start();
  particulas = new ArrayList <Particula> ();
  for(int i = 0; i<400; i++){
    particulas.add(new Particula());
  }
}

void draw(){
  background(255);
  for(Particula p:particulas){
    p.display();
    p.mover();
  }
  
  for(int i = particulas.size()-1; i>0; i--){
    boolean salio  = particulas.get(i).salio();
    if(salio){
      particulas.remove(i);
    }
  }
  
  if(mousePressed){
    Particula p = new Particula();
  particulas.add(p);
   p = new Particula();
  particulas.add(p);

  }
}

void mousePressed(){
  Particula p = new ParticulaA();
  particulas.add(p);
}

void keyPressed(){
  if(key == 'a'){
  Particula p = new Particula(mouseX, mouseY);
  particulas.add(p);
  }
  if(key == 'b'){
  Particula p = new ParticulaB();
  particulas.add(p);
  }
  if(key == 'c'){
  Particula p = new ParticulaC();
  particulas.add(p);
  }
}

class Particula {
  PVector pos;
  PVector dir;
  float t;
  color c;
  
  Particula(){
    pos = new PVector(random(width),random(height));
    dir = PVector.random2D();
    t = random(40,80);
    c = color(random(255),random(255),random(255));
  }
  
  Particula(int x_, int y_){
    pos = new PVector(x_,y_);
    dir = PVector.random2D();
    t = random(40,80);
    c = color(random(255),random(255),random(255));
  }
  
  void display(){
    c = camara.get(round(pos.x),round(pos.y));
    noStroke();
    fill(c);
    ellipse(pos.x,pos.y,t,t);
  }
  
  void mover(){
    pos.add(dir);    
  }
  
  boolean salio(){
    boolean respuesta = false;
    if(pos.x<-t/2||pos.x>width+t/2|| pos.y<-t/2 || pos.y>height+t/2){
      respuesta = true; 
    }
    return respuesta;
  }  
}

class ParticulaA extends Particula{
  float dv;
  ParticulaA(){
    super(mouseX,mouseY);
    dv = 0.05;
  }
  
  void mover(){
    float velActual = dir.mag();
    dir.setMag(velActual+dv);
    pos.add(dir);
  }  
}

class ParticulaB extends Particula{
  float dr;
  ParticulaB(){
    super(mouseX,mouseY);
    dr = random(-0.01,0.01);
  }
  
  void mover(){
    dir.rotate(dr);
    pos.add(dir);
  }
}

class ParticulaC extends Particula{
  float dt;
  ParticulaC(){
    super(mouseX,mouseY);
    dt = random(-0.5,0.5);
  }
  
  void mover(){
    super.mover();
    t+=dt;
  }
}
void captureEvent(Capture c) {
  c.read();
}
