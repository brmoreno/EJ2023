PImage fuente;
PImage fuenteColor;
float m;
float n;
float magB;
PVector r,g,b;
PVector r0,g0,b0;

void setup(){
  size(1000,600);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,600);
  fuenteColor = fuente.copy();
  r = new PVector(random(255),random(255),random(255));
  g = new PVector(random(255),random(255),random(255));
  b = new PVector(random(255),random(255),random(255));
  r0 = new PVector(random(-50,50),random(-50,50),random(-50,50));
  g0 = new PVector(random(-50,50),random(-50,50),random(-50,50));
  b0 = new PVector(random(-50,50),random(-50,50),random(-50,50));
}

void draw(){
  color c[] = {color(0,255,255),color(255,0,255),color(255,255,0),color(255,0,0),color(0,0,255),color(0,255,0),color(255),color(0)};
  fuenteColor = clusterize(fuente,c,5);
  image(fuenteColor,0,0);
}

class VectorC extends PVector{
  float a;
  VectorC(color c_){
    super();
    a = (c_ >> 24) & 0xFF;
    super.x = (c_ >> 16) & 0xFF;
    super.y = (c_ >> 8) & 0xFF;
    super.z = c_ & 0xFF;;   
  }
  
  color getColor(){    
    return(round(constrain(a,0,255))<<24|round(constrain(x,0,255))<<16|round(constrain(y,0,255))<<8|round(constrain(z,0,255)));
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
      axisx *= mag; axisy *= mag; axisz *= mag;
      xsq = axisx * axisx; ysq = axisy * axisy; zsq = axisz * axisz;
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
    float tempx = x; float tempy = y;
    x = ix * x + jx * y + kx * z;
    y = iy * tempx + jy * y + ky * z;
    z = iz * tempx + jz * tempy + kz * z;
    return this;
  }
  
  PVector rotate(float angle, PVector axis) {
    return rotate(angle, axis.x, axis.y, axis.z);
  }
}


PImage clusterize(PImage p_, int n_, int m_){
  
  PVector pos[] = new PVector[n_];
  PVector suma[] = new PVector[n_];
  int cuantas[] = new int[n_];
  
  for (int i = 0; i<n_; i++) {
    float val = (255f/(n_-1))*i;
    pos[i] = new PVector(val, val, val);
    suma[i] = new PVector(0,0,0);
  }
  
  for(int j = 0; j< m_; j++){
    for(int i = 0; i<p_.pixels.length; i++){
      VectorC vc = new VectorC(p_.pixels[i]);
      int aPintar = -1;
      float dm = 441.67294;
      for(int k = 0; k<n_; k++){
        float dist = vc.dist(pos[k]);
        if(dist < dm){
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
  
  for(int i = 0; i<p_.pixels.length; i++){
    VectorC vc = new VectorC(p_.pixels[i]);
    int aPintar = -1;
    float dm = 441.67294;
    for(int k = 0; k<n_; k++){
      float dist = vc.dist(pos[k]);
      if(dist < dm){
        dm = dist;
        aPintar = k;
      }
    }
    p_.pixels[i] = color(pos[aPintar].x,pos[aPintar].y,pos[aPintar].z);
  }
  return p_;
}

PImage clusterize(PImage p_, color c_[], int m_){
  int n_ = c_.length;
  PVector pos[] = new PVector[n_];
  PVector suma[] = new PVector[n_];
  int cuantas[] = new int[n_];
  
  for (int i = 0; i<n_; i++) {
    pos[i] = new VectorC(c_[i]);
    suma[i] = new PVector(0,0,0);
  }
  
  for(int j = 0; j< m_; j++){
    for(int i = 0; i<p_.pixels.length; i++){
      VectorC vc = new VectorC(p_.pixels[i]);
      int aPintar = -1;
      float dm = 441.67294;
      for(int k = 0; k<n_; k++){
        float dist = vc.dist(pos[k]);
        if(dist < dm){
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
  
  for(int i = 0; i<p_.pixels.length; i++){
    VectorC vc = new VectorC(p_.pixels[i]);
    int aPintar = -1;
    float dm = 441.67294;
    for(int k = 0; k<n_; k++){
      float dist = vc.dist(pos[k]);
      if(dist < dm){
        dm = dist;
        aPintar = k;
      }
    }
    p_.pixels[i] = color(pos[aPintar].x,pos[aPintar].y,pos[aPintar].z);
  }
  return p_;
}
