PImage fuente;
PImage fuenteColor;
PGraphics pg1,pg2,pg3;
PImage recorte;
Clust clust;
void setup() {
  size(1000, 600);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000, 600);
  fuenteColor = fuente.copy();
  clust = new Clust(fuente,3,5);
  pg1 = createGraphics(width,height);
  pg2 = createGraphics(width,height);
  pg3 = createGraphics(width,height);
}


float d = 0;
void draw(){
  pg1.beginDraw();
  pg1.background(random(255),random(255),random(255));
  for(int i = 0; i<width;i+=10){
    for(int j = 0; j<height;j+=10){
    pg1.ellipse(i,j,10,10);
    }
  }
  pg1.endDraw();
  
  pg2.beginDraw();
  for(int i = 0; i<width;i+=10){
    for(int j = 0; j<height;j+=10){
    pg2.rect(i,j,10,10);
    }
  }
  
  pg2.endDraw();
  
  pg3.beginDraw();
  pg3.background(255);
  for(int i = 0; i<width;i+=10){
    for(int j = 0; j<height;j+=10){
    pg3.line(i,j,i+random(-20,20),j+random(-20,20));
    }
  }
  pg3.endDraw();
  
  background(255);
  for(int j = 0; j<3; j++){
    recorte = new PImage(width,height,ARGB);
    color comp = color(clust.pos[j].x,clust.pos[j].y,clust.pos[j].z);
    for(int i = 0; i<fuente.pixels.length;i++){
      color c = clust.p.pixels[i];
      if(c == comp){
        recorte.pixels[i] = color(255);
      }
      else{
        recorte.pixels[i] = color(0);
      }
    }
    if(j == 0){
    pg1.mask(recorte);
    image(pg1,0,0);
    }
    
    if(j == 1){
    pg2.mask(recorte);
    image(pg2,0,0);
    }
    
    if(j == 2){
    pg3.mask(recorte);
    image(pg3,0,0);
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
