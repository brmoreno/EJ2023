PImage fuente;
PImage fuenteColor;

ArrayList <Agente> agentes;
ArrayList <Nodo> nodos;

void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(width,height);
  fuente.filter(POSTERIZE,3);
  agentes = new ArrayList <Agente>();
  nodos = new ArrayList <Nodo>();
  for(int i = 0; i<1; i++){
    agentes.add(new Agente(400));
  }
  
 
  background(255);
  
  for(Agente a:agentes){    
      a.display();   
  }
  //image(fuente,0,0);
}

class Agente{
  ArrayList <PVector> posiciones;
  PVector pos;
  PVector dir; 
  int n;
  float t;
  int contador;
  int limiteMax;
  
  
  float dr;
  float dt;
  float maxt;
  float alfa;
  color inicial;
  float sat;
  
  Agente(int n_){
    n = n_;
    posiciones = new ArrayList <PVector>();
    for(int i = 0; i<n; i++){
      posiciones.add(new PVector(random(width),random(height)));
    }
    t = 5;
    pos = new PVector();
  }
  
  
  
  void display(){
      for(int i = 0; i<posiciones.size()-1; i++){
        PVector pinicio = posiciones.get(i);
        PVector pfin = posiciones.get(i+1);
        float dist = pinicio.dist(pfin);
        
        for(int j = 0; j< dist; j++){
          pos = PVector.lerp(pinicio,pfin,j/dist);
           t = noise(j*0.01,i)*10; 
        
      color c = fuente.get(round(pos.x),round(pos.y)); 
      PVector a1 = PVector.random2D().mult(t/2);
      PVector a2 = PVector.random2D().mult(t/2);
      a1.add(pos);
      a2.add(pos);
      
      strokeWeight(0.5);
      stroke(c);
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
      }
         
    }
  }
