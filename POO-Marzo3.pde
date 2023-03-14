Juego elJuego;

void setup(){
  size(500,500);
  elJuego = new Juego();
  }

void draw(){
  background(255);
  elJuego.display();
}

void keyPressed(){
  elJuego.enElKeyPressed();
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

class Juego{
  int pantalla; //0:inicio, 1:juego, 2:ganaste, 3:terminaste niveles, 4: perdiste, 5: game over;
  int nivel;
  int vida;
  int max = 5;
  Nivel elNivel;
  
  Juego(){
    pantalla = 0;
    nivel = 1;
    vida = 3;
    Enemigo uno = new Enemigo(100,100,120,0);
    elNivel = new Nivel(1,400,400,uno);
  }
  
  void display(){
    println(vida);
    switch(pantalla){
      case 0:
        inicio();
      break;
      case 1:
        elNivel.display();
        if(elNivel.estado == 1){       
          nivel++;
          if(nivel == max){
            pantalla = 3;
          }
          else{
          pantalla = 2;
          }
        }
        if(elNivel.estado == 2){  
          vida--;
          if(vida <0){
            pantalla = 5;
          }
          else{
          pantalla = 4;
          }
        }
      break;
      case 2:
        ganaste();
      break;
      case 3:
        finNiveles();        
      break;
      case 4:
        perdiste();
      break;
      case 5:
        gameOver();
      break;
    }
  }
  
  void inicio(){
    fill(0);
    text("INICIO",100,100);
  }
  
  void ganaste(){
    fill(0);
    text("GANASTE",100,100);
  }
  
  void finNiveles(){
    fill(0);
    text("TERMINASTE EL JUEGO",100,100);
  }
  
  void perdiste(){
    fill(0);
    text("PERDISTE",100,100);
  }
  
  void gameOver(){
    fill(0);
    text("GAME OVER",100,100);
  }
  
  void enElKeyPressed(){
    switch(pantalla){
      case 0:
        if(key == 'z'){
          pantalla = 1;
        }
      break;
      case 2:
        if(key == 'z'){
          elNivel = construyeNivel(nivel);
          pantalla = 1;
        }
      break;
      case 3:
         nivel = 1;
         vida = 3;
         elNivel = construyeNivel(nivel);
         pantalla = 0;
      break;
      case 4:
        elNivel = construyeNivel(nivel);
        pantalla = 1;
      break;
      case 5:
        nivel = 1;
         vida = 3;
         elNivel = construyeNivel(nivel);
         pantalla = 0;
      break;
    }
  }
  
  Nivel construyeNivel(int n_){
    Enemigo uno = new Enemigo(100,100,120,0);
    Enemigo dos;
    Enemigo tres;
    Enemigo cuatro; 
    Nivel nivel = new Nivel(1,400,400,uno) ;
    switch(n_){
      case 1:
      break;
      case 2:
      uno = new Enemigo(400,400,100,1);
      dos = new Enemigo(100,100,120,0);
      nivel = new Nivel(2,100,400,uno,dos);
      break;
      case 3:
      uno = new Enemigo(400,400,100,1);
      dos = new Enemigo(100,100,120,0);
      tres = new Enemigo(500,500,60,2);
      nivel = new Nivel(2,100,400,uno,dos,tres);
      break;
      case 4:
      uno = new Enemigo(400,400,100,1);
      dos = new Enemigo(100,100,120,0);
      tres = new Enemigo(500,500,60,2);
      cuatro = new Enemigo(400,100,60,2);
      nivel = new Nivel(2,100,400,uno,dos,tres,cuatro);
      break;
    
    }    
    return nivel;
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


class Nivel{
  Jugador elJugador;
  Item elItem;
  Enemigo uno;
  Enemigo dos;
  Enemigo tres;
  Enemigo cuatro;
  int estado; //0= sigo jugando; 1= gane; 2= perdí
  
  Nivel(float v_,float x_, float y_, Enemigo e_){
    elJugador = new Jugador(v_);
    elItem = new Item(x_,y_);
    uno = e_;
  }
  
  Nivel(float v_,float x_,float y_,Enemigo e1_,Enemigo e2_){
    elJugador = new Jugador(v_);
    elItem = new Item(x_,y_);
    uno = e1_;
    dos = e2_;
  }
  
  Nivel(float v_,float x_,float y_,Enemigo e1_,Enemigo e2_,Enemigo e3_){
    elJugador = new Jugador(v_);
    elItem = new Item(x_,y_);
    uno = e1_;
    dos = e2_;
    tres = e3_;
  }
  
  Nivel(float v_,float x_,float y_,Enemigo e1_,Enemigo e2_,Enemigo e3_, Enemigo e4_){
    elJugador = new Jugador(v_);
    elItem = new Item(x_,y_);
    uno = e1_;
    dos = e2_;
    tres = e3_;
    cuatro = e4_;
  }
  
  void display(){
    elJugador.display();
    elJugador.mover();
    elItem.display();
    if(elJugador.captura(elItem)){
      estado = 1;
    }
    funcionEnemigo(uno);
    funcionEnemigo(dos);
    funcionEnemigo(tres);
    funcionEnemigo(cuatro);
  }
  
  void funcionEnemigo(Enemigo e_){
    if(e_ != null){
      e_.display();
      e_.mover();
      if(elJugador.colision(e_)){
        estado = 2;
      }
    }
  }
  
  int estado(){
    return estado;
  } 
}
