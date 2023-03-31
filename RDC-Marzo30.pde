import toxi.geom.*;
import toxi.geom.mesh2d.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.processing.*;

PImage fuente;
PImage fuenteColor;
PImage textura;

ToxiclibsSupport gfx;
Voronoi voronoi;



void setup(){
  size(1000,665);
  fuente = loadImage("fotogatas.jpg");
  fuente.resize(1000,665);
  fuenteColor = fuente.copy();
  textura = fuente.copy();
  fuenteColor.filter(BLUR,10);
  fuenteColor.filter(GRAY);
  
  
  voronoi = new Voronoi();
  gfx = new ToxiclibsSupport(this);
  
  voronoi.addPoint(new Vec2D(0,0));
  voronoi.addPoint(new Vec2D(width,0));
  voronoi.addPoint(new Vec2D(0,height));
  voronoi.addPoint(new Vec2D(width,height));
  for(int i = 0; i<600; i++){
    voronoi.addPoint(new Vec2D(random(width), random(height)));
  }
  
   
  ArrayList <Triangle2D> triangulos = new ArrayList <Triangle2D>(); 
  ArrayList <Rect> rects = new ArrayList <Rect>(); 
  ArrayList <Rect> recto = new ArrayList <Rect>(); 
  for (Triangle2D t : voronoi.getTriangles()) {
    triangulos.add(t);
    recto.add(t.getBounds().copy());
    Rect r = t.getBounds();    
    r.x = random(width-r.width);
    r.y = random(height-r.height);
    rects.add(r);
  }  
  
  PVector colores [] = new PVector[triangulos.size()];
  int ncolores[] = new int [triangulos.size()];
  for(int i = 0; i<colores.length; i++){
    colores[i] = new PVector(0,0,0);
  }
  
  for(int i = 0; i<fuente.pixels.length;i++){
    int x = i%fuente.width;
    int y = i/fuente.width;
    Vec2D consulta = new Vec2D(x,y);
    for(int j = 0; j<triangulos.size(); j++){
      if(triangulos.get(j).containsPoint(consulta)){
        color c = fuente.pixels[i];
        float rojo = red(c);
        float verde = green(c);
        float azul = blue(c);
        colores[j].add(new PVector(rojo,verde,azul));
        ncolores[j]++;
        int posx = round(x-recto.get(j).x+rects.get(j).x);
        int posy= round(y-recto.get(j).y+rects.get(j).y);
        textura.pixels[i] = color(map(red(fuenteColor.get(posx,posy)),0,255,0,100));
        break;        
      }
    }
  }
  
  for(int i= 0; i<triangulos.size(); i++){
    colores[i].div(ncolores[i]);
    color c = color(colores[i].x,colores[i].y,colores[i].z);
    fill(c);
    triangle(triangulos.get(i).a.x,triangulos.get(i).a.y,triangulos.get(i).b.x,triangulos.get(i).b.y,triangulos.get(i).c.x,triangulos.get(i).c.y);
  } 
  blendMode(SUBTRACT);
  image(textura,0,0);
}
