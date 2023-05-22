import gab.opencv.*;
import java.util.Comparator;
import java.util.Map;
import java.awt.Rectangle;
PImage fuente;
PImage fuenteColor;
OpenCV opencv; 
ArrayList <Contour> contours;
Clust clust;
int in = 0;
ArrayList <ContourColor> contourColores;
void setup() {
  size(1000, 600);
  background(255);
 contourColores = new ArrayList <ContourColor> ();
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,600);
  clust = new Clust(fuente,20,20);
  fuenteColor = fuente.copy();
  opencv = new OpenCV(this,fuente);
  for(int j = 0; j<clust.pos.length; j++){
    for (int i = 0; i<fuenteColor.pixels.length; i++) {
    color c = clust.p.pixels[i];
    color comp = color(clust.pos[j].x,clust.pos[j].y,clust.pos[j].z);
    if(c == comp){
      fuenteColor.pixels[i] = color(255);
    }
    else{
      fuenteColor.pixels[i] = color(0);
    }
  }  
  opencv.loadImage(fuenteColor);
  opencv.dilate();
  contours = opencv.findContours(false,true);
  for(Contour c:contours){
    contourColores.add(new ContourColor(c,color(clust.pos[j].x,clust.pos[j].y,clust.pos[j].z)));
  }
  }
  
  contourColores.sort(VEC_CMP.reversed());
  for(ContourColor c: contourColores){
    float dist = dist(width/2,height/2,c.centro.x,c.centro.y);
    if(dist<300){
      c.display(2);
    }
  }
  
  
}


class Clust {
  PVector pos[];
  PImage p;

  Clust(PImage p_, int n_, int m_) {
    pos = new PVector[n_];
    PVector suma[] = new PVector[n_];
    int cuantas[] = new int[n_];

    for (int i = 0; i<n_; i++) {
      float val = (255f/(n_-1))*i;
      pos[i] = new PVector(val, val, val);
      suma[i] = new PVector(0, 0, 0);
    }

    for (int j = 0; j< m_; j++) {
      for (int i = 0; i<p_.pixels.length; i++) {
        VectorC vc = new VectorC(p_.pixels[i]);
        int aPintar = -1;
        float dm = 441.67294;
        for (int k = 0; k<n_; k++) {
          float dist = vc.dist(pos[k]);
          if (dist < dm) {
            dm = dist;
            aPintar = k;
          }
        }

        suma[aPintar].x+= vc.x;
        suma[aPintar].y+= vc.y;
        suma[aPintar].z+= vc.z;
        cuantas[aPintar]++;
      }

      for (int i = 0; i<n_; i++) {
        pos[i].x = suma[i].x/cuantas[i];
        pos[i].y = suma[i].y/cuantas[i];
        pos[i].z = suma[i].z/cuantas[i];
      }
      for (int i = 0; i<n_; i++) {
        suma[i] = new PVector(0, 0, 0);
        cuantas[i] = 0;
      }
    }
    p = p_.copy();
    for (int i = 0; i<p_.pixels.length; i++) {
      VectorC vc = new VectorC(p_.pixels[i]);
      int aPintar = -1;
      float dm = 441.67294;
      for (int k = 0; k<n_; k++) {
        float dist = vc.dist(pos[k]);
        if (dist < dm) {
          dm = dist;
          aPintar = k;
        }
      }
      p.pixels[i] = color(pos[aPintar].x, pos[aPintar].y, pos[aPintar].z);
    }
  }
}

class VectorC extends PVector {
  float a;
  VectorC(color c_) {
    super();
    a = (c_ >> 24) & 0xFF;
    super.x = (c_ >> 16) & 0xFF;
    super.y = (c_ >> 8) & 0xFF;
    super.z = c_ & 0xFF;
    ;
  }

  color getColor() {    
    return(round(constrain(a, 0, 255))<<24|round(constrain(x, 0, 255))<<16|round(constrain(y, 0, 255))<<8|round(constrain(z, 0, 255)));
  }

  PVector rotate(float angle, float axisx, float axisy, float axisz) {
    float xsq = axisx * axisx;
    float ysq = axisy * axisy;
    float zsq = axisz * axisz;
    float mag = xsq + ysq + zsq;
    if (mag < EPSILON || (x == 0.0 && y == 0.0 && z == 0.0)) {
      return this;
    } else if (mag > 1.0) {
      mag = 1.0 / sqrt(mag);
      axisx *= mag; 
      axisy *= mag; 
      axisz *= mag;
      xsq = axisx * axisx; 
      ysq = axisy * axisy; 
      zsq = axisz * axisz;
    }
    float cosa = cos(angle);
    float sina = sin(angle);
    float complcos = 1.0 - cosa;
    float complxy = complcos * axisx * axisy;
    float complxz = complcos * axisx * axisz;
    float complyz = complcos * axisy * axisz;
    float sinx = sina * axisx;
    float siny = sina * axisy;
    float sinz = sina * axisz;
    float ix = complcos * xsq + cosa; /* m00 */
    float iy = complxy + sinz; /* m10 */
    float iz = complxz - siny; /* m20 */
    float jx = complxy - sinz; /* m01 */
    float jy = complcos * ysq + cosa; /* m11 */
    float jz = complyz + sinx; /* m21 */
    float kx = complxz + siny; /* m02 */
    float ky = complyz - sinx; /* m12 */
    float kz = complcos * zsq + cosa; /* m22 */
    float tempx = x; 
    float tempy = y;
    x = ix * x + jx * y + kx * z;
    y = iy * tempx + jy * y + ky * z;
    z = iz * tempx + jz * tempy + kz * z;
    return this;
  }

  PVector rotate(float angle, PVector axis) {
    return rotate(angle, axis.x, axis.y, axis.z);
  }
}

class ContourColor{
  PVector centro;
  Contour c;
  color col;
  ContourColor(Contour c_, color col_){
    c = c_;
    col = col_;
    Rectangle box = c.getBoundingBox();
    centro = new PVector(box.x+box.width/2,box.y+box.height/2);
  } 
  
  void display(float pA){
    c.setPolygonApproximationFactor(pA);
    ArrayList <PVector> pvs = c.getPolygonApproximation().getPoints();
    
    strokeWeight(0.5);
    stroke(col);
    noFill();
    beginShape();    
    for(PVector p: pvs){
      p.add(PVector.random2D().mult(4));
      vertex(p.x,p.y);
    }
    endShape();   
  }
}

Comparator<ContourColor> VEC_CMP = new Comparator<ContourColor>() {
  int compare(final ContourColor a, final ContourColor b) {
    return
      Float.compare(a.c.area(), b.c.area());
  }
};
