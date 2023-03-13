PImage fuente;
PImage fuenteColor;

int t = 40;
int r = 40;

void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,665);
  for(int i = 0; i<width; i+=t){
    for(int j = 0; j<height; j+= t){
      
      if(((j+i)/t)%2 ==0){
        for(int k = 0; k<t;k++){
          lineaP(i,j+k,i+t,j+k,fuente);
        }
      }
      else{
        for(int k = 0; k<t;k++){
          lineaP(i+k,j,i+k,j+t,fuente);
        }
      }
      
    }
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
