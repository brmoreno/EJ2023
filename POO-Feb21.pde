Jugador elJugador;

void setup(){
  size(500,500);
  elJugador = new Jugador(2);
}

void draw(){
  background(255);
  elJugador.display();
  elJugador.mover();
}

class Enemigo{
  int t; //diametro;
  float x;
  float y;
  color c;
  // almacenar si el enemigo es estático, aleatorio o constate;
  int comportamiento; //  0= estático, 1 = aleatorio, 2= constante;
  
  Enemigo(float x_, float y_, int t_,int comp_){
    x = x_;
    y = y_;
    t = t_;
    comportamiento = comp_;
    c = color(0,0,255);
  }
  
  void mover(){
  }
  
  void display(){
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
  void colision(){
  }
  
  // captura del item
  void captura(){
  }
}
