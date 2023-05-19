ArrayList <Caja> cajas;

void setup(){
  size(500,500,P3D);
  cajas = new ArrayList <Caja>();
  for(int i = 0; i<100; i++){
    cajas.add(new Caja());
  }
}

float rx;
float ry;
void draw(){
  lights();
  background(255);
  pushMatrix();
  translate(width/2,height/2);
  rotateX(mouseX*0.01);
  rotateY(mouseY*0.01);
  for(Caja c: cajas){
    c.display();
  }
  popMatrix();

}

class Caja{
  PVector posicion;
  float r;
  float dr;
  color c;
  float d;
  float t ; 
  float rots[];
  float drots[];
  float dt;
  float ddt;
  
  
  Caja(){
    posicion = PVector.random3D();
    r = random(TWO_PI);
    dr = random(-0.01,0.01);
    c = color (random(255),random(255),random(255));
    d = random(200,300);
    t = random(30,60);
    rots = new float [3];
    drots = new float [3];
    for(int i = 0; i<3; i++){
      rots[i] = random(TWO_PI);
      drots[i] = random(-0.1,0.1);
    }
    dt = random(TWO_PI);
    ddt = random(0.05);
  }
  
  void display(){
    posicion.rotate(dr);
    pushMatrix();
    PVector copia = posicion.copy();
    dt+=ddt;
    for(int i = 0; i<3; i++){
      rots[i] += drots[i];
    }
    float fact  = sin(dt);
    copia.setMag(d*fact);
    translate(copia.x,copia.y,copia.z);
    rotateX(rots[0]);
    rotateY(rots[1]);
    rotateZ(rots[2]);
    fill(c);
    box(t);
    popMatrix();
  }
}
