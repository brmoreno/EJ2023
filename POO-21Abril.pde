
interface Particula{
  void mover();
  void display();
  boolean destruir();
}

class ParticulaA implements Particula{
  PVector pos;
  PVector dir;
  float t;
  int max;
  int contador;
  
  ParticulaA(){
    pos = new PVector(random(width),random(height));
    dir = PVector.random2D();
    t = random(10,20);
    max = round(random(10,100));
    contador = 0;
  }
  
  void mover(){
    pos.add(dir);
    contador++;
  }
  
  void display(){
    noStroke();
    color c = fuente.get(round(pos.x),round(pos.y));
    fill(c);
    ellipse(pos.x,pos.y,t,t);
  }
  
  boolean destruir(){
    
    boolean res =false;
    if(pos.x<0|| pos.x>width || pos.y<0 || pos.y>height){
      res = true; 
    }
    if(contador>max){
      res = true;
    }
    return res;    
  }
}

class ParticulaB implements Particula{
  PVector centro;
  PVector pos;
  float t;
    int max;
  int contador;
  
  ParticulaB (){
    centro = new PVector(random(width), random(height));
    t = random(30,70);
    pos = PVector.random2D().mult(random(t));   
    max = round(random (50,200));
    contador = 0;
  }
  
  void mover(){
    pos = PVector.random2D().mult(random(t));
    contador++;
  }
  
  void display(){
    pos.add(centro);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(random(TWO_PI));
    color c = fuente.get(round(pos.x),round(pos.y));
    fill(c);
    noStroke();
    rect(0,0,random(1,30),random(1,30));
    popMatrix();
  }
  boolean destruir(){
    boolean res = false;
    if(contador>max){
      res = true;
    }
    return res;
  }
}

class ParticulaC implements Particula{
  PVector p1;
  PVector p2;
  PVector d1;
  PVector d2;
  int max;
  int contador;
  
  ParticulaC(){
    p1 = new PVector(random(width), random(height));
    p2 = new PVector(random(width), random(height));
    d1 = PVector.random2D();
    d2 = PVector.random2D();
    max = round(random (50,200));
    contador = 0;
  }
  
  void mover(){
    p1.add(d1);
    p2.add(d2);
    contador++;
  }
  
  void display(){
    color c = fuente.get(round(p1.x),round(p1.y));
    stroke(c);
    line(p1.x,p1.y,p2.x,p2.y);
  }
  boolean destruir(){
    boolean res = false;
    if(contador>max){
      res = true;
    }
    return res;
  }
}

PImage fuente;

ArrayList <Particula> particulas;

void setup(){
  size(1000,700);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,700);
  particulas = new ArrayList <Particula>();
  for(int i = 0; i<20; i++){
    particulas.add(new ParticulaA());
    particulas.add(new ParticulaB());
    particulas.add(new ParticulaC());

  }
  background(255);
}

void draw(){
  for(Particula p: particulas){
    p.mover();
    p.display();
  }
  for(int i = particulas.size()-1; i>= 0; i--){
    if(particulas.get(i).destruir()){
      particulas.remove(i);
    }
  }
}

