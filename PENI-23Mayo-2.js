let x;
let y;
let t;
let c;
let dx;


function setup(){
  createCanvas(400,400);
  background(255);
  x = 0;
  y = 200;
  t = 100;
  c = color(255,0,0);
  dx = 0.3;
}

function draw(){
  background(255);
  x+= dx;
  fill(c);
  noStroke();
  ellipse(x,y,t,t);
  if(x>400){
      dx*= -1;
  }
  
  if(x<0){
    dx*=-1; 
  }
  
}
