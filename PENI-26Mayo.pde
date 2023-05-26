let x;
let y;
let w;
let h;

let c1;
let c2;

let sobre;
function setup(){
  createCanvas(400,400);
  x = 100;
  y = 100;
  w = 100;
  h = 50;
  
  c1 = color(255,0,0);
  c2 = color(255,255,0);
}

function draw(){
 if(sobre){
    fill(c2);
  }
  else{
    fill(c1);
  }
   
  if(mouseX>x && mouseX< x+w && mouseY>y && mouseY<y+h){
       sobre = true;
     }
  else{
    sobre = false;
  }
 rect(x,y,w,h);
}
