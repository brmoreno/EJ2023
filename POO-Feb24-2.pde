Jugador elJugador;
Enemigo enemigouno;
Enemigo enemigodos;
Enemigo enemigotres;
Item elItem;

void setup(){
  size(500,500);
  elJugador = new Jugador(2);
  enemigouno = new Enemigo(100,100,100,0);
  enemigodos = new Enemigo(400,100,100,1);
  enemigotres = new Enemigo(400,400,100,2);
  elItem = new Item(400,400);
}

void draw(){
  background(255);
  
  enemigouno.display();
  enemigouno.mover();
  enemigodos.display();
  enemigodos.mover();
  enemigotres.display();
  enemigotres.mover();
  elJugador.display();
  elJugador.mover();
  elItem.display();
  if(elJugador.colision(enemigouno)){
    println("colision con uno ");
  }
  else if(elJugador.colision(enemigodos)){
    println("colision con dos ");
  }
  else if(elJugador.colision(enemigotres)){
    println("colision con tres ");
  }
  else if(elJugador.captura(elItem)){
    println("item capturado");
  }
  else{
    println(" ");
  }   
}


class Enemigo{
  int t; //diametro;
  float x;
  float y;
  color c;
  float dx;
  float dy;
  // almacenar si el enemigo es estático, aleatorio o constate;
  int comportamiento; //  0= estático, 1 = aleatorio, 2= constante;
  
  Enemigo(float x_, float y_, int t_,int comp_){
    x = x_;
    y = y_;
    t = t_;
    comportamiento = comp_;
    c = color(0,0,255);
    float a = random(TWO_PI);
    dx = sin(a)*2;
    dy = cos(a)*2;
  }
  
  void mover(){
    switch(comportamiento){
      case 0:
        estatico();
      break;
      case 1:
        aleatorio();
      break;
      case 2:
        constante();
      break;
    }
  }
  
  void estatico(){
    
  }
  
  void aleatorio(){
    x+=random(-2,2);
    y+=random(-2,2);
    x = constrain(x,0,width);
    y = constrain(y,0,width);
  }
  
  void constante(){
    x+=dx;
    y+=dy;
    if(x<t/2 || x>width-t/2){
      dx*=-1;
    }
    if(y<t/2 || y>height-t/2){
      dy*=-1;
    }
  }
  
  void display(){
    noStroke();
    fill(c);
    ellipse(x,y,t,t);
  }
}


class Item{ 
  int t;
  float x;
  float y;
  color c;
  
  Item(float x_, float y_){
    x = x_;
    y = y_;
    t = 20;
    c = color(255,255,0);
  }
  
  void display(){
    noStroke();
    fill(c);
    ellipse(x,y,t,t);
  }  
}



class Jugador{
  int t; //diametro;
  float x;
  float y;
  color c;
  float v;
  float a;
  
  Jugador(float v_){
    t = 60;
    x = width/2;
    y = height/2;
    c = color(255,0,0);
    v = v_;
    a = 0;
  }
  
  // moverse
  void mover(){
    if(keyPressed){
      if(key == 'a'){
        a-=0.1;
      }
      if(key == 'd'){
        a+=0.1;
      }
    }    
    float dx = cos(a)*v;
    float dy = sin(a)*v;
    x+=dx;
    y+=dy;
    
    x = constrain(x,0,width);
    y = constrain(y,0,height);
  }
  
  void display(){
    noStroke();
    fill(c);
    ellipse(x,y,t,t);
  }
  
  //colision con enemigos
  boolean colision(Enemigo e_){
    boolean colision = false;
    float distancia = dist(this.x,this.y,e_.x,e_.y);
    float minimo = (this.t/2) + (e_.t/2);
    if(distancia<minimo){
      colision = true;
    }
    return colision;
  }
  
  // captura del item
  boolean captura(Item i_){
    boolean captura = false;
    float distancia = dist(this.x,this.y,i_.x,i_.y);
    float minimo = (this.t/2) + (i_.t/2);
    if(distancia<minimo){
      captura = true;
    }
    return captura;
  }
}
