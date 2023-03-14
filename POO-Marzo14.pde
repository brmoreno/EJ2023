class Caracter{
  //Atributos
  float x,y;
  float t;
  color c;
  char car;
  float dx,dy;
  PFont pf;
  float a;
  float da;
  
  //Constructor
  Caracter(char car_, float x_, float y_){
    car = car_;
    x = x_;
    y = y_;
    t = random(50,100);
    c = color(random(100,255),random(0,60),random(255));
    dx = random(-2,2);
    dy = random(-2,2);
    pf = createFont(nombreFuentes[floor(random(nombreFuentes.length))],t);
    a = random(TWO_PI);
    da = random(-0.1,0.1);
}
  
  //Métodos;
  
  void display(){
    pushMatrix();
    translate(x,y);
    rotate(a);
    fill(c);
    textFont(pf);
    textSize(t);
    textAlign(CENTER,CENTER);
    text(car,0,0);
    popMatrix();
  }
  
  void mover(){
    x+=dx;
    y+=dy;
    a+=da;
    if(x<0||x>width){
      dx*=-1;
      t+=10;
    }
    if(y<0||y>height){
      dy*=-1;
      t+=10;
    }
  }  
}

String t;
PFont fuente;
PFont otraFuente;
String[] nombreFuentes;

Caracter uno;
Caracter dos;
Caracter tres;


void setup(){
  size(500,500);
  nombreFuentes = PFont.list();
  uno = new Caracter('f',100,100);
  dos = new Caracter('o', 100,150);
  tres = new Caracter('o',100, 200);   
}

void draw(){
  background(255);
  uno.display();
  dos.display();
  tres.display();
  uno.mover();
  dos.mover();
  tres.mover();
}
