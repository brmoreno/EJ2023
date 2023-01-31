void setup(){
  size(400,400);
  background(255);
}

void draw(){
  noStroke();
  fill(255,0,0);  
  if(mousePressed == true){
    ellipse(mouseX, mouseY,40,40);
  }
  
  // si presiono w pinto de color verde;
  // si presiono e pinto de color azul;
  // si presiono r pinto de color rojo;
  
  if(keyPressed){
    if(key == 'q'){
      background(255);
    }    
  }
}
