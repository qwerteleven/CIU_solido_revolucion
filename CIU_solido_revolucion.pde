boolean finish_perfil = false;
Figure figure;

class Point {

  float x;
  float y;
  float z;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  } 
  
  Point(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
}

class Figure {
  int angle = 4;
  ArrayList<Point> perfil = new ArrayList<Point>();
  Point[][] m;
  
  PShape obj;
  boolean build = false;
  
  void reset() {
    
    build = false;
    perfil = new ArrayList<Point>();
  }
  
  void build_figure() {
    m = new Point[360 / angle][perfil.size()];
    generate_meridians();
    Point point_A;
    Point point_B;
    noFill();
    obj = createShape();
    obj.beginShape(TRIANGLE_STRIP);
    obj.stroke(255, 0, 0);
    obj.strokeWeight(2);
    
    for (int i = 0; i < m.length; i++) {
      for (int j = 0; j < m[0].length; j++){ 
        point_A = m[i][j];
        point_B = m[(i + 1) % m.length][j];
        
        obj.vertex(point_A.x, point_A.y, point_A.z);
        obj.vertex(point_B.x, point_B.y, point_B.z);
      }
        point_A = m[i][0];
        obj.vertex(point_A.x, point_A.y, point_A.z);
    }
    
    obj.endShape();
    build = true;
  }
  
  
  void generate_meridians() {
    Point point;
    float x_, y_, z_;
    
    for (int i = 0; i < perfil.size(); i++) {
      point = perfil.get(i);
      x_ = point.x - width/2;
      y_ = point.y;
      z_ = point.x - width/2;
      
      m[0][i] = new Point(x_, y_, z_);
    }
    
    
    for (int i = 1; i < m.length; i++) {
      for (int j = 0; j < m[i].length; j++) {
        point = m[i-1][j];
        x_ = (point.x) * cos(gr_to_rd(angle)) - point.z * sin(gr_to_rd(angle));
        y_ = point.y;
        z_ = (point.x) * sin(gr_to_rd(angle)) + point.z * cos(gr_to_rd(angle));
      
        m[i][j] = new Point(x_, y_, z_);
        
      }
    }
  }
  
  
PShape get_obj () {
    return obj;
  }  
}


float gr_to_rd(float gr) {
  
  return gr * PI / 180;
}


void setup() {
  size(1000, 1000, P3D);
  figure = new Figure();
}


void draw(){
  background(255);
  stroke(255, 0, 0);
  
  if (!figure.build) {
    line(width/2 ,0 , width/2, height);
    draw_current_perfil();
    textSize(24);
    text("Click Izquierdo: Vertices del perfil \n"+
         "Click Derecho: Finaliza, Resetea la Figura \n"+
         "*punto de fuga, centro del lienzo", 10, 30);  
    fill(0, 102, 153, 204);
  } else {
    translate(width/2, 0, -100);
    shape(figure.obj);
  }
}


void new_point(){
  if (figure.perfil.size() == 0) {
    figure.perfil.add(new Point(width/2, mouseY));
  }
  
  figure.perfil.add(new Point(mouseX, mouseY));
}

void draw_current_perfil() {
  
  for (int i = 0; i < figure.perfil.size()-1; i++) {
    line(figure.perfil.get(i).x, figure.perfil.get(i).y, figure.perfil.get(i+1).x, figure.perfil.get(i+1).y);
  }

}

void reset() {

  finish_perfil = false;
  figure.reset();
}


void mouseClicked() {
  
    if (mouseButton == LEFT && !finish_perfil) {
      new_point();
    }
    
    if (mouseButton == RIGHT ) {
      if (!finish_perfil && figure.perfil.size() > 0) {
        finish_perfil = true;
        Point last_point = figure.perfil.get(figure.perfil.size() - 1);
        figure.perfil.add(new Point(width/2, last_point.y));
        figure.build_figure();
      } else {
        reset();
      }
    }
}
