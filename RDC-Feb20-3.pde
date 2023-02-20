PImage fuente;



void setup() {
  size(1000, 600);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000, 600);
  image(fuente,0,0);  
}

void draw() {
  int x = round(random(0,width));
  int y = round(random(0,height));
  int w = round(random(50,100));
  int h = round(random(50,100));
  PImage recorte = fuente.get(x,y,w,h);
  float r = random(-50,50);
  float g = random(-50,50);
  float b = random(-50,50);
  for(int i = 0; i<recorte.pixels.length;i++){
    color c = recorte.pixels[i];
    recorte.pixels[i] = color(red(c)+r,green(c)+g,blue(c)+b);
  }
  imageMode(CENTER);
  float dx = random(-10,10);
  float dy = random(-10,10);
  pushMatrix();
  translate(x+(w/2)+dx,y+(h/2)+dy);
  scale(random(0.7,1.6));
  rotate(random(-QUARTER_PI,QUARTER_PI));
  image(recorte,0,0);
  popMatrix();  
}
