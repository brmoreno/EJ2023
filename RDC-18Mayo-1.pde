import gab.opencv.*;
PImage fuente;
OpenCV opencv; 
ArrayList <Contour> contours;
void setup() {
  size(1000, 600);
  background(255);
  for( float j = 0; j<1; j+=0.25){
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,600);
  fuente.filter(THRESHOLD,j);
  opencv = new OpenCV(this,fuente);
  opencv.loadImage(fuente);
  opencv.invert();
  contours = opencv.findContours(true,true);

  for(int i = 0; i<contours.size(); i++){
    
    contours.get(i).setPolygonApproximationFactor(random(1,5));
    ArrayList <PVector> pvs = contours.get(i).getPolygonApproximation().getPoints();
    noFill();
    stroke(0);
    beginShape();
    for(PVector p: pvs){
      vertex(p.x+random(-2,2),p.y+random(-2,2));
    }
    endShape();    
  }
  }
}
