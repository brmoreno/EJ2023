size(500,500);
loadPixels();
for(int i=0; i<pixels.length;i++){
  int x = i%width;
  int y = i/width; 
  //pixels[i] = color(map(y,0,499,0,255),map(x,0,499,0,255),0);
  
  
  //if(x<250){
  //  pixels[i] = color(0,map(y,0,499,0,255),0);
  //}
  //else{
  //  pixels[i] = color(0,map(y,0,499,255,0),0);
  //}
  
  //if(x%6 > 3){
  //  pixels[i] = color(255,0,0);
  //}
  //else{
  //  pixels[i]= color(0,0,255);
  //}
  
  
  //float r = 0;
  //float g = 0;
  //float b = 0;  
  //if( x%10<3){
  //  r += 80;
  //}
  //if( y%20<5){
  //  g += 100;
  //}
  //if( x%6<3){
  //  b += 120;
  //}
  
  //if( x%20<5){
  //  r += 120;
  //}
  //if( y%12<10){
  //  g += 10;
  //}
  //if( x%15<7){
  //  b += 90;
  //}  
  //pixels[i] = color(r,g,b);
  
  
  int xa = 250;
  int ya = 250;
  
  float dist = dist(xa,ya,x,y);
  pixels[i] = color(map(dist,0,250,255,0));
  
  
  
}

updatePixels();
