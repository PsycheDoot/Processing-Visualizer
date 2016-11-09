class SquareSpiral {
  int x, y;
  int vx = 1, 
      vy = 1;
  int rot = 0;
  boolean clockwise = false;
  int size;
  int depth;
  int tweak = 20;
  ArrayList<PVector> colors = new ArrayList<PVector>();
  SquareSpiral(int s, int d) {
    x = width-(width/2);
    y = height-(height/2);
    size = s;
    depth = d;
    for (int i = 0; i < depth; ++i) {
      colors.add(new PVector(random(255), random(2555), random(255)));
    }
  }
  
  void update(float mod) {
    // Rotation
    if (clockwise)
      ++rot;
    else
      --rot;
      
    // Position
    x += vx*mod*tweak;
    y += vy*mod*tweak;
    if (x > width - size/2 || x < 0 + size/2) {
      if (x > width - size/2)
        x = width - size/2;
      else
        x = 0 + size/2;
      vx *= -1;
      clockwise = !clockwise;
      for (int i = 0; i < depth; ++i) {
        colors.set(i, new PVector(random(255), random(255), random(255)));
      }
    }
    if (y > height - size/2 ||  y < 0 + size/2) {
      if (y > height - size/2)
        y = height - size/2;
      else
        y = 0 + size/2;
        vy *= -1;
      clockwise = !clockwise;
      for (int i = 0; i < depth; ++i) {
        colors.set(i, new PVector(random(255), random(255), random(255)));
      }
    }
  }
  
  void display() {
    for (int i = depth; i > 0; --i) {
      fill(colors.get(i-1).x, colors.get(i-1).y, colors.get(i-1).z);
      stroke(0);
      pushMatrix();
      translate(x,y);
      rotate(radians(rot*i));
      rect(-((size*i)/2),-((size*i)/2),size*i,size*i);
      popMatrix();
    }
  }
}