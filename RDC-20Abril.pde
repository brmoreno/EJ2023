class Agente{
  PVector pos;
  PVector dir; 
  float t;
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
  }
  
  void mover(){
    dir.rotate(dr);
    float angulo = noise(pos.x*0.005,pos.y*0.005)*TWO_PI;
    dir = PVector.fromAngle(angulo);
    pos.add(dir);
    t+=dt;
    t = constrain(t,0,maxt);
  }
  
  void display(){
    noStroke();
    int px = floor(pos.x);
    int py = floor(pos.y);
    int pt = floor(t/2);
    
    float rojo = 0;
    float verde = 0;
    float azul = 0;
    
    for(int i = px-pt; i<px+pt;i++){
      for(int j = py-pt; j<py+pt;j++){
        color c = fuente.get(i,j);
        rojo+= red(c);
        verde+= green(c);
        azul+= blue(c);
      }
    }    
    rojo /= pow(pt*2,2);
    verde /= pow(pt*2,2);
    azul /= pow(pt*2,2);
    
    alfa-=5;
    alfa = constrain(alfa,0,255);
    color defuente = color(rojo,verde,azul); 
    inicial = lerpColor(inicial,defuente,0.05);
    fill(inicial,alfa);
    //color c = fuente.get(round(pos.x),round(pos.y));
    //fill(c);
    ellipse(pos.x,pos.y,t,t);
  }  
}

PImage fuente;
PImage textura;

ArrayList <Agente> agentes;

void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(width,height);
  agentes = new ArrayList <Agente>();
  for(int i = 0; i<3000; i++){
    agentes.add(new Agente(random(width),random(height),random(10,30)));
  }
  background(255);
  
  for(Agente a:agentes){
    for(int i = 0; i<50;i++){
      a.mover();
      a.display();
    }
  }
}
