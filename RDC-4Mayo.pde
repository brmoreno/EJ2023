PImage fuente;
PImage fuenteColor;

ArrayList <Agente> agentes;
ArrayList <Nodo> nodos;

void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(width,height);
  fuente.filter(GRAY);
  fuente.filter(POSTERIZE,3);
  agentes = new ArrayList <Agente>();
  nodos = new ArrayList <Nodo>();
  for(int i = 0; i<20000; i++){
    agentes.add(new Agente(random(width),random(height),random(2,5)));
  }
  
  for(int i = 0; i<500; i++){
    nodos.add(new Nodo());
  }
  background(255);
  
  for(Agente a:agentes){    
      a.display();   
  }
  //image(fuente,0,0);
}

class Agente{
  PVector pos;
  PVector dir; 
  float t;
  int contador;
  int limiteMax;
  
  
  float dr;
  float dt;
  float maxt;
  float alfa;
  color inicial;
  float sat;
  
  Agente(float x_, float y_, float t_){
    sat = 0;
    inicial = fuente.get(round(x_),round(y_));//color(random(255),random(255),random(255));
    pos = new PVector(x_,y_);
    dir = new PVector(1,0);
    dr = random(-0.05,0.05);
    t = t_;
    maxt = t_;
    dt = random(-t*0.001,-t*0.1);
    alfa = 255;
    
    contador = 0;
    limiteMax = round(random(10,50));
  }
  
  void mover(){
      dir = new PVector(0,0);
      for(Nodo n:nodos){
        float dist = pos.dist(n.pos);
        if(dist<n.t){
          PVector nd = pos.copy().sub(n.pos).normalize();
          float intensidad = map(dist,n.t,0,0,n.f);
          nd.mult(intensidad);
          dir.add(nd);
        }
      };
      dir.normalize();
      pos.add(dir);
  }
  
  void display(){
    while(contador < limiteMax){
      mover();
      color c = fuente.get(round(pos.x),round(pos.y));
      float sat = red(c);
      if(sat<255){
      t = map(sat,0,255,10,0);
      PVector a1 = dir.copy().rotate(HALF_PI).mult(t/2);
      PVector a2 = dir.copy().rotate(-HALF_PI).mult(t/2);
      a1.add(pos);
      a2.add(pos);
      
      strokeWeight(0.5);
      stroke(0);
      float fin = 0;
      float inicio = 0;
      while(fin<1){
        fin+=random(0.1);
        PVector pi = PVector.lerp(a1,a2,inicio);
        PVector pf = PVector.lerp(a1,a2,fin);     
        line(pi.x,pi.y,pf.x,pf.y);
        fin+=random(0.1);
        inicio = fin;
      }
      }
      contador++;
     
    }
  }
}

class Nodo{
  PVector pos;
  float t;
  float f;
  
  Nodo(){
    pos = new PVector(random(width),random(height));
    t = random(50,200);
    f  = random(-10,10);
  }
  
}
