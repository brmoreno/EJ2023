int x;
int y;
int t;
int n;
color c;

void setup() {
  size(500, 500);
  background(255);
  x = width/2;
  y = height/2;
  t = 200;
  n = 5;
  c = color(255, 0, 0);
}

void draw() {
  background(255);
  noFill();
  stroke(c);
  concentricos(x, y, t, n); 

  // descomenta el bloque para trabajar con el evento contínuo 
  /* 
  if (keyPressed) {
    switch(key) {
    case 'w':
      y-= 5;
      break;
    case 's':
      y += 5;
      break;
    case 'a':
      x -= 5;
      break;
    case 'd':
      x += 5; 
      break;
    case  'j':
      t+=5;
      break;
    case 'k':
      n++;
      break;
    }
  }
  */
}

void keyPressed() {
  switch(key) {
  case 'w':
    y-= 5;
    break;
  case 's':
    y += 5;
    break;
  case 'a':
    x -= 5;
    break;
  case 'd':
    x += 5; 
    break;
  case  'j':
    t+=5;
    break;
  case 'k':
    n++;
    break;
  }
}


void concentricos (float x_, float y_, float t_, float n_) {  
  for (int i = 0; i<n_; i++) {
    ellipse(x_, y_, (t_-i*(t_/n_)), (t_-i*(t_/n_)));
  }
}
