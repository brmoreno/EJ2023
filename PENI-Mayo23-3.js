let x;
let y;
let t;
let c;
let dx;
let dy;

let px = 200;
let py = 200;

 
function setup() {
  createCanvas(400, 400);
  background(255);
  x = 200;
  y = 200;
  t = 20;
  c = color(255,0,0);
  dx = 0.5;
  dy = 1;
 
}

 

function draw(){
  background(0,0,255);
  x+= dx;
  y+= dy;
  fill(c);
  noStroke();
  ellipse(x,y,t,t);
  fill(0);
  ellipse(mouseX,mouseY,40,40);
  
  fill(0,255,0);
  ellipse(px,py,50,50);
  
  if(keyIsPressed){
     if(key == 'a'){
          px--;
        } 
    if(key == 'd'){
        px++;
       }
  }
  if(x > width-t/2){
    dx*= -1;
     }
  if(x < 0 + t/2){
    dx*= -1;
  }

  if(y > height -t/2){
    dy*= -1;
  }

  if(y < 0 + t/2){
    dy*= -1;
  }
}
