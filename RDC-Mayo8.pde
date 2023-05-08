PImage fuente;
PImage textura;

ArrayList <Agente> agentes;


void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(width,height);
  agentes = new ArrayList <Agente>();

  for(int i = 0; i<1000; i++){
    agentes.add(new Agente(round(random(width)),round(random(height)),random(20,100)));
  }
  background(255);
  loadPixels();
  for(Agente a:agentes){
    a.display();
  }
  
  updatePixels();
  
}

class Agente{
  int x;
  int y;
  float t;
  int dx;
  float v1;
  float v2;
  
  Agente(int x_, int y_, float t_){
    x = x_;
    y = y_;
    t = t_;
    dx = round(random(-2,2));
    v1 = random(HALF_PI);
    v2 = random(HALF_PI,PI);
  }
  
  void display(){
    x+=dx;
    color c = fuente.get(x,y);
    for(int i = (x-round(t))>0? x-round(t): 0 ; i<x+round(t)&&i<width; i++){
       for(int j = (y-round(t))>0? y-round(t): 0 ; j<y+round(t)&&j<height; j++){
         float dist = dist(i,j,x,y);
         if(dist<t){
            color actual =  pixels[i+j*width];
            float sat = map(dist,0,t,1,0);
            float sat2 = map(sat,1,0,v1,v2);
            color fin = lerpColor(actual,c,sin(sat2)*sat);
            pixels[i+j*width] = fin;
         }      
      } 
    }
  }
}
