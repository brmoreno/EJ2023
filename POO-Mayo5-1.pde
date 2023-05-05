import processing.video.*;
Movie video;
ArrayList <Recorte> recortes;
void setup() {
  size(500, 500);
  video = new Movie(this, "scream2.mp4");
  video.loop();
  while (video.width == 0) {
    println(video.width);
  }
  recortes = new ArrayList <Recorte>();
  for (int i = 0; i<4; i++) {
    for (int j = 0; j<4; j++) {
      recortes.add(new Recorte(i*width/4, j*height/4,width/4));
    }
  }
}

void draw() {
  for (Recorte r : recortes) {
    r.display();
  }
}

void movieEvent(Movie m) {
  m.read();
}
