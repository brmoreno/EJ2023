PImage fuente;
PImage fuenteColor;
int t;

void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,665);
  t = 10;
}

void draw(){
  fuenteColor = fuente.copy();
  for(int i = 0; i < fuente.pixels.length; i++){
    color c = fuente.pixels[i];
    float r  = round(red(c));
    float g = round(green(c));
    float b = round(blue (c));
    r= noise(r*0.01,0,0)*355;
    g = noise(0,g*0.01,0)*355;
    b = noise(0,0,b*0.01)*355;;
    fuenteColor.pixels[i] = color(g,b,r);
  }

  
  for(int i = 0; i< width; i+= t){
    for(int j = 0; j < height; j+= t){
      float r = 0;
      float g = 0;
      float b = 0;
      for (int k = 0 ; k < t; k+=1){
        for(int l = 0; l < t; l+=1){
          color c = fuenteColor.get(i+k,j+l);
          r +=  red(c);
          g += green(c);
          b += blue(c);
        }
      }
      color c = color(r/(t*t),g/(t*t),b/(t*t));
      
      //noStroke();
      //color c = fuente.get(i,j);

      //color c = fuente.get(i+round(random(t)),j+round(random(t)));
      fill(c);
      rect(i,j,t,t);
    }
  }
}

void keyPressed(){
  if(key == 'a'){
    t++;
  }
  
  if(key  == 's'){
    t--;
  }
  t = constrain(t,1,100);

}
