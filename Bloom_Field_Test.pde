void setup() {
  //Line 1
  
  size(500,500);
  
  PVector p1 = new PVector(1, 3);
  PVector p2 = new PVector(3, 3);  

  //Line 2
  PVector p3 = new PVector(2, 1);
  PVector p4 = new PVector(2, 4);
  
  //Line 3
  PVector p5 = new PVector(10,10);
  PVector p6 = new PVector(10,20);
  noLoop();

  if (doLinesIntersect(p1, p2, p3, p4)) {
    println("Intersects!\n\n");
    return;
  } else {
  print("Non");
  
  }
  
  println("Attempt 2 - shouldn't work");
   if (doLinesIntersect(p1, p2, p5, p6)) {
    print("Intersects!");
    return;
  }
  print("Non");
}

boolean doLinesIntersect(PVector p1, PVector p2, PVector p3, PVector p4) {
  PVector r = subtractPoints(p2, p1);
  PVector s = subtractPoints(p4, p3);

  float uNum = crossProduct(subtractPoints(p3, p1), r);
  float denom = crossProduct(r, s);

  if (uNum == 0 && denom == 0) {
    //They are collinear

    //Do they touch
    if ( arePointsEqual(p1, p3) || arePointsEqual(p1, p4) || arePointsEqual(p2, p3) || arePointsEqual(p2, p4)) {
      return true;
    }

    ArrayList<Boolean> args = new ArrayList<Boolean>();

    args.add(p3.x - p1.x < 0);
    args.add(p3.x - p2.x < 0);
    args.add(p4.x - p1.x < 0);      
    args.add(p4.x - p2.x < 0);

    boolean firstResult = !allEqual(args);

    args = new ArrayList<Boolean>();

    args.add(p3.y - p1.y < 0);
    args.add(p3.x - p2.y < 0);
    args.add(p4.y - p1.y < 0);      
    args.add(p4.y - p2.y < 0);

    boolean secondResult = !allEqual(args);



    return firstResult || secondResult;
  }

  if (denom == 0) {
    return false;
  }

  float u = uNum / denom;
  float t = crossProduct(subtractPoints(p3, p1), s)/denom;
  if ((t >= 0) && (t <= 1) && (u >= 0) && (u <= 1)) {
    PVector intersection = new PVector();
    println(p1.x + " " + t + " " + s.x);
    println(p1.y + " " + t + " " + s.y);
    intersection.x = p1.x + (t* r.x);
    intersection.y = p1.y + (t* r.y);

    println(intersection.x + " - " + intersection.y);
    return true;
  }
  return false;
}

PVector subtractPoints(PVector p1, PVector p2) {  
  PVector result = new PVector(p1.x-p2.x, p1.y-p2.y);
  return result;
  
}

boolean arePointsEqual(PVector p1, PVector p2) {
  return (p1.x == p2.x) && (p1.y == p2.y);
}

float crossProduct(PVector p1, PVector p2 ) {
  float result = (p1.x * p2.y) - (p1.y * p2.x);
  println("Part 1");
  println(p1.x * p2.y);
  println("Part 2");
  println(p1.y*p2.x);
  println("Result: " + result);
  return result;
}

boolean allEqual(ArrayList<Boolean> args) { //Need params 
  boolean first = args.get(0);

  for (int i = 1; i < args.size(); i++) {
    if (args.get(i) != first) {
      return false;
    }
  }
  return true;
}

class Edge {
  PVector start;
  PVector finish;
  
  Edge(PVector start, PVector finish) {
    this.start = start;
    this.finish = finish;
  }
  
  void draw() {
    strokeWeight(1);
    line(start.x,start.y,finish.x,finish.y);
  }
}


class Mesh {
  ArrayList<PVector> points;
  PVector midpoint = null;
  
  ArrayList<Edge> edges;
  Mesh() {
    this.points = new ArrayList<PVector>();
    this.edges = new ArrayList<Edge>();
  }
  
  void add_edge_from_points(PVector start, PVector finish) {
    
    Edge newEdge = new Edge(start,finish);
    
    this.points.add(start);
    this.points.add(finish);
    
    this.edges.add(newEdge);
  
  }
  
  void draw() {
    this.draw_edges();
    this.draw_midpoint();
  }
  
  void draw_edges() {
    for(int i = 0 ; i < this.edges.size() ; i++) {
      this.edges.get(i).draw();
    
    }
  
  }
  void calculate_midpoint() {
     PVector average = new PVector();
     for(int i = 0 ; i < this.points.size() ; i++) {
       PVector current = this.points.get(i);
       average.x += current.x;
       average.y += current.y;
     }
     average.x /= this.points.size();
     average.y /= this.points.size();
     println(average.x + " - " + average.y);
     this.midpoint = average;
  }
  
  void triangle_form(PVector p1, PVector p2, PVector p3) {
    //TODO
  }
  
  void bloom() {
    int cellSize = 20;
    
  }
  
  void drawCell(PVector origin, int cellSize) {
    //Origin acts as bottom left hand corner
    line(origin.x, origin.y, origin.x,origin.y + cellSize);
  }
  
  void draw_midpoint() {
    //TODO
    if(this.midpoint == null )
    {
      this.calculate_midpoint();
    }
    strokeWeight(3);
    point(this.midpoint.x, this.midpoint.y);
  }
  
}
void draw() {
  Mesh testMesh = new Mesh();
  
  testMesh.add_edge_from_points(new PVector(250,250), new PVector(350,250));
  testMesh.add_edge_from_points(new PVector(350,250),new PVector(250,450));
  testMesh.add_edge_from_points(new PVector(250,450),new PVector(250,250));
  
  testMesh.draw();
  
  
}