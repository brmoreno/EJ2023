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
  voronoi = new Voronoi();
  gfx = new ToxiclibsSupport(this);
  
  for(int i = 0; i<700; i++){
    voronoi.addPoint(new Vec2D(random(width), random(height)));
  }
  background(255);
  fill(255);
  stroke(0);
  
  //for(Polygon2D poly : voronoi.getRegions()){
  //  gfx.polygon2D(poly);
  //}
  
 
  for (Triangle2D t : voronoi.getTriangles()) {
    Vec2D ancla = t.a;
    Vec2D inicio = t.b;
    Vec2D fin = t.c;
    float dist = dist(inicio.x,inicio.y,fin.x,fin.y);
    
    for(int i = 0; i<dist; i++){
      float px = lerp(inicio.x,fin.x,i/dist*1f);
      float py = lerp(inicio.y,fin.y,i/dist*1f);
      color col = fuente.get(round(px),round(py));
      stroke(col);
      line(ancla.x,ancla.y,px,py);
    }
    
  }  
}
