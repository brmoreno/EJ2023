import gab.opencv.*;

PImage fuente;
PImage fuenteColor;
OpenCV opencv; 
ArrayList <Contour> contours;
int in = 0;
int paso = 0;
void setup() {
  size(1000, 600);
  background(255);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,600);
  opencv = new OpenCV(this,fuente);
  contours = new ArrayList <Contour> ();
}
int vx;
int vy;
void draw(){
  if (paso == 0){
  vx = round( map(mouseX,0,width,1,255));
  vy = round( map(mouseY,0,height,1,255));
  opencv.loadImage(fuente);
  opencv.findCannyEdges(vx, vy);
  image(opencv.getOutput(),0,0);
  }
  if(paso == 1){
    background(255);
    for(Contour c:contours){
      c.setPolygonApproximationFactor(random(1,5));
      ArrayList <PVector> pvs = c.getPolygonApproximation().getPoints();
       strokeWeight(0.5);
    stroke(0);
    noFill();
    beginShape();    
    for(PVector p: pvs){
      p.add(PVector.random2D().mult(4));
      vertex(p.x,p.y);
    }
    endShape();
    }
  }
   
}

void keyPressed(){
  contours = opencv.findContours();
  paso = 1;
}
