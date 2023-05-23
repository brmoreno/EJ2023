let x = 0;
let y = 0;
let w = 200;
let h = 200;

let r = 0;
let g = 0;
let b = 0;

let dr ;
let dg ;
let db ;

let dx;
let dy;


function setup() {
  createCanvas(400, 400);
  background(25,120,255);
  dr = random(0,0.2);
  dg = random(0,0.2);
  db = random(0,0.2);
  dx = random(0,0.2);
  dy = random(0,0.2);
}

function draw(){
  r+=dr;
  g+=dg;
  b+=db;
  x+=dx;
  y+=dy;
  
  let rojo = sin(r)*127 +127;
  let verde = sin(g)*127 + 127;
  let azul = sin(b)*127 + 127;
  
  let px = sin(x)*200 + 200;
  let py = sin(y)*200 + 200;
  
  fill(rojo,verde,azul);
  noStroke();
  rect(px,py,w,h);
}
