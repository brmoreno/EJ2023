color fondo = color(random(0,255),random(0,255),random(0,255));
int r = round(random(255)),g = round(random(255)),b = round(random(255));
float x = random(500);
float y = random(500);
float w = random(50,200);
float h = random(50,200);

size(500,500);

background(fondo);
fill(r,g,b);
noStroke();
ellipse(x,y,w,h);
