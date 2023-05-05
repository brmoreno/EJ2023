import processing.video.*;
Capture camara;

void setup(){
  size(500,500);
  String[] cameras = Capture.list();

  camara = new Capture(this, cameras[0]);
  camara.start();

}

int t;
void draw(){
  t = mouseX+3;
  for(int i = 0; i<width; i+=t){
    for(int j = 0; j<height; j+=t){
      color c = camara.get(i,j);
      stroke(c);
      strokeWeight(random(0.5,t/2));
      line(i,j,i+random(-t*2,t*2),j+random(-t*2,t*2));
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}
