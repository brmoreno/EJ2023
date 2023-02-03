float x[] = new float[100];
float y[] = new float[100];
float t[] = new float[100];
float r[] = new float[100];
float g[] = new float[100];
float b[] = new float[100];
float dx[] = new float[100];
float dy[] = new float[100];

void setup() {
  size(600, 500);
  background(255);
  for (int i = 0; i<100; i++) {
    x [i] = random(width);
    y [i] = random(height);
    t [i] = random(50, 100);
    r [i] = random(255);
    g [i] = random(255);
    b [i] = random(255);
    dx [i] = random(-1, 1);
    dy [i] = random(-1, 1);
  }
}

void draw() {
  background(255);
  for ( int i = 0; i<100; i++) {
    fill(r[i], g[i], b[i]);
    noStroke();
    ellipse(x[i], y[i], t[i], t[i]);
    x[i] += dx[i]; 
    y[i] += dy[i];

    if (x[i] > width- t[i]/2) {
      dx[i] *= -1;
    }

    if (x[i] < t[i]/2) {
      dx[i] *= -1;
    } 

    if (y[i] > height -t[i]/2) {
      dy[i] *= -1;
    }

    if (y[i]<t[i]/2) {
      dy[i]*= -1;
    }
  }
}
