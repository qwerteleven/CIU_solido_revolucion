
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
  int angle = int(PI/0.1);
  ArrayList<Point> perfil = new ArrayList<Point>();
  Point[][] m;
  
  PShape obj;
  boolean build = false;
  
  void build_figure() {
    m = new Point[angle][perfil.size()];
    generate_meridians();
    Point point_A;
    Point point_B;
    noFill();
    obj = createShape();
    obj.beginShape(TRIANGLE_STRIP);
    obj.stroke(255, 0, 0);
    obj.strokeWeight(2);
    
    for (int i = 0; i < m[0].length; i++) {
      for (int j = 0; j < m.length; j++){ 
        point_A = m[j][i];
        point_B = m[j][(i + 1) % m[0].length];
        
        obj.vertex(point_A.x, point_A.y, point_A.z);
        obj.vertex(point_B.x, point_B.y, point_B.z);
      }
        point_A = m[0][i];
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
        x_ = (point.x) * cos(angle) - point.z * sin(angle);
        y_ = point.y;
        z_ = (point.x) * sin(angle) + point.z * cos(angle);
      
        m[i][j] = new Point(x_, y_, z_);
        
      }
    }
  }
  
  
  PShape get_obj () {
    return obj;
  }  
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


void mouseClicked() {
  
    if (mouseButton == LEFT && !finish_perfil) {
      new_point();
    }
    
    if (mouseButton == RIGHT && !finish_perfil) {
      finish_perfil = true;
      Point last_point = figure.perfil.get(figure.perfil.size() - 1);
      figure.perfil.add(new Point(width/2, last_point.y));
      figure.build_figure();
    }
    
    
}
