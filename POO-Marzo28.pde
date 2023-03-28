Juego ppt;
void setup(){
  size(500,500);
  ppt = new Juego();
}

void draw(){
  background(255);
  fill(0);
  ppt.display();
}

void keyPressed(){
  ppt.enKeyPressed();  
}

class Juego {
  Partida p;
  int Puntosj1;
  int Puntosj2;
  int seguidasJ1;
  int seguidasJ2;
  int pantalla;
  
  Juego(){
    p = new Partida();
    Puntosj1 = 0;
    Puntosj2 = 0;
    seguidasJ1 = 0;
    seguidasJ2 = 0;
    pantalla = 0;
  }
  
  void display(){
    switch(pantalla){
      case 0:
        text("Presiona n para comenzar",200,200);
      break;
      case 1:
        text(Puntosj1, 50,50);
        text(Puntosj2, 450,50);
        p.display();
        p.operacion();
      break;
     case 2:
       pantallaFinal();
     break;
    }
  }
  
  
  void pantallaFinal(){
    if(Puntosj1 == 5){
      text("GANO J1", 200, 200);
    }
    else if(Puntosj2 == 5){
      text("GANO J2", 200, 200);
    }
    if(seguidasJ1 == 3){
      text("GANO J1", 200, 200);
    }
    else if(seguidasJ2 == 3){
      text("GANO J2", 200, 200);
    }
  }
  
  void enKeyPressed(){
    if(pantalla == 0 && key == 'n'){
      pantalla = 1;
    }
    if(pantalla == 2 && key == 'n'){
      p = new Partida();
      Puntosj1 = 0;
      Puntosj2 = 0;
      seguidasJ1 = 0;
      seguidasJ2 = 0;
      pantalla = 0;
    }
    
    if(pantalla == 1){
      p.enKeyPressed();
      if(p.estado  == 1 && key == 'n'){
        if(p.resultado == 1){
          Puntosj1++;
          seguidasJ1++;
          seguidasJ2 = 0;
        }
        if(p.resultado == 2){
          Puntosj2++;
          seguidasJ2++;
          seguidasJ1 = 0;
        }        
        p = new Partida();
        if(Puntosj1 == 5 || Puntosj2 == 5){
          pantalla = 2;
        }
        if(seguidasJ1 == 3 || seguidasJ2 == 3){
          pantalla = 2;
        }
      }
    }
  }
}

class Jugador{
  int x,y;
  boolean yaJugo;
  int jugada; // 1:piedra, 2: papel, 3: tijeras;
  
  Jugador(int x_, int y_){
    x = x_;
    y = y_;
    yaJugo = false;
    jugada = 0;
  }
  
  void juega(int n_){
    if(!yaJugo){
      jugada = n_;
      yaJugo = true;
    }
  }
  
  void display(){
    switch(jugada){
      case 1:
      text("piedra", x,y);
      break;
      case 2:
      text("papel", x,y);
      break;
      case 3:
      text ("tijeras", x,y);
      break;
    }
  }
  
  void idle(){
    text("juega" ,x,y);
  }
}

class Partida{
  int estado; // 0: jugando, 1:terminé
  Jugador uno;
  Jugador dos;
  int resultado; // 1: si gana j1, 2: si gana j2; 3: empate
  
  Partida(){
    uno = new Jugador(100,100);
    dos = new Jugador(100,300);
    estado = 0;
  }
  
  void display(){
    if(estado == 0){
      uno.idle();
      dos.idle();
    }
    if(estado == 1){
      uno.display();
      dos.display();
      switch(resultado){
        case 1:
          text("Ganó j1", 100,400);
        break;
        case 2:
          text("Ganó j2", 100,400);
        break;
        case 3:
          text("Empate", 100,400);
        break;
      }
    }
  }
  
  void operacion(){
    if(uno.yaJugo && dos.yaJugo){
      estado = 1;
    }    
    if(estado ==1){
      if(uno.jugada == 1 && dos.jugada ==2){
        resultado = 2;
      }
      if(uno.jugada == 1 && dos.jugada ==3){
        resultado = 1;
      }
      if(uno.jugada == 2 && dos.jugada ==1){
        resultado = 1;
      }
      if(uno.jugada == 2 && dos.jugada == 3){
        resultado = 2;
      }
      if(uno.jugada == 3 && dos.jugada ==1){
        resultado = 2;
      }
      if(uno.jugada == 3 && dos.jugada ==2){
        resultado = 1;
      }
      if(uno.jugada == dos.jugada){
        resultado = 3;
      }
    }
  }
  
  void enKeyPressed(){
    switch(key){
      case 'a':
        uno.juega(1);
      break;
      case 's':
        uno.juega(2);
      break;
      case 'd':
        uno.juega(3);
      break;
      case 'j':
        dos.juega(1);
      break;
      case 'k':
        dos.juega(2);
      break;
      case 'l':
        dos.juega(3);
      break;     
    }
  }
}
