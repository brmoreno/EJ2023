import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

PImage fuente;
PImage fuenteColor;

ToxiclibsSupport gfx;
Voronoi voronoi;



void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,665);
  fuenteColor = fuente.copy();
  fuenteColor.filter(INVERT);
  voronoi = new Voronoi();
  gfx = new ToxiclibsSupport(this);
  
  for(int i = 0; i<1200; i++){
    voronoi.addPoint(new Vec2D(random(width), random(height)));
  }
  background(255);
  fill(255);
  
  noStroke();
  for(Polygon2D poly : voronoi.getRegions()){
    for(int i = 0; i<11; i++){
      if(i != 0){
        poly.scaleSize(0.8);
      }
      Vec2D pos = poly.getRandomPoint();
      color col = fuente.get(round(pos.x),round(pos.y));
      if(i%3==0){
        col = fuenteColor.get(round(pos.x),round(pos.y));
      }
      fill(col);
      gfx.polygon2D(poly);
    }
  }  
}
