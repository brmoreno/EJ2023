PImage fuente;
PImage fuenteColor;

int t = 1;
int r = 40;

void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,665);
  for(int k = 0; k<10000; k+=t){
      float i = random(width);
      float j = random(height);
      lineaI(i,j,i+random(-100,100),j+random(-100,100),fuente,random(3,30));

  }  
}

void lineaP(float x1_,float y1_,float x2_,float y2_, PImage img_){
  PVector inicio = new PVector(x1_,y1_);
  PVector fin = new PVector(x2_,y2_);
  float dist = PVector.dist(inicio,fin);
  float r = 0;
  float g = 0;
  float b = 0;
  for(int i = 0; i<dist;i++){
    PVector pool = PVector.lerp(inicio,fin,i/(dist*1f));
    color c = img_.get(round(pool.x),round(pool.y));
    r+= red(c);
    g+= green(c);
    b+= blue(c);
  }
  r/=dist;
  g/=dist;
  b/=dist;
  stroke(r,g,b);
  line(x1_,y1_,x2_,y2_);
}


void lineaI(float x1_,float y1_,float x2_,float y2_, PImage img_, float t_){
  PVector inicio = new PVector(x1_,y1_);
  PVector fin = new PVector(x2_,y2_);
  float dist = PVector.dist(inicio,fin);
  color ci = img_.get(round(inicio.x),round(inicio.y));
  color cf = img_.get(round(fin.x),round(fin.y));
  for(int i = 0; i<dist; i++){
    PVector p = PVector.lerp(inicio,fin,i/(dist*1f));
    color c = lerpColor(ci,cf,i/(dist*1f));
    noStroke();
    fill(c);
    ellipse(p.x,p.y,t_*i/(dist*1f),t_*i/(dist*1f));
  }  
}
