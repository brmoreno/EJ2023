//DVG
color fondo;
color relleno;
int x,y,t;


void setup(){
  size(500,500);
  fondo = color(random(255));
  relleno = color(random(255),random(255),random(255));
  x =100;
  y = 250;
  t = 100;
  background(fondo);
}

void draw(){
  background(fondo);
  noStroke();
  fill(relleno);
  ellipse(x,y,t,t);
  x+= 1;
  x%=500;
}
