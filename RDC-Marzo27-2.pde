PImage fuente;
PImage fuenteColor;

void setup() {
  size(1000, 600);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000, 600);
  fuenteColor = fuente.copy();
  int t1 = 7;
  int t2 = 15;
  IntList orden = new IntList();  
  for(int i = 0; i<(width*height)/t1;i++){
    orden.append(i);
  }
  orden.shuffle();
   
  for(int i = 0; i<orden.size(); i++){
    int val = orden.get(i);
    int x = val%(width/t1);
    int y = val/(width/t1);
    color c = fuente.get(x*t1,y*t1);
    fill(c);
    stroke(c);
    float xp = x*t1+random(-3,3);
    float yp = y*t1+random(-3,3);
    float A = t2*random(0.4,1.4);
    float B = t2*random(0.4,1.4);
    float C = t2*random(0.4,1.4);
    float D = t2*random(0.4,1.4);
    pushMatrix();   
    translate(xp,yp);
    rotate(random(PI));
    arc(0,0,A,B,0,HALF_PI*1.0);
    arc(0,0,C,B,HALF_PI,PI*1.0);
    arc(0,0,C,D,PI,PI+HALF_PI*1.0);
    arc(0,0,A,D,PI+HALF_PI,TWO_PI*1.0);

    line(0+A/2,0,0-C/2,0);
    line(0,0+B/2,0,0-D/2);
    popMatrix();
  }
}
