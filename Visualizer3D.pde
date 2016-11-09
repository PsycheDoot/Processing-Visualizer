import processing.sound.*;
class Visualizer3D {
  int sensitivity;
  int bandsVisible;
  int resolution;
  Visualizer3D(int sens, int bandvis, int res) {
    sensitivity = sens;
    bandsVisible = bandvis;
    resolution = res;
  }
  
  void update(int sens, int bandvis, int res) {
    sensitivity = sens;
    bandsVisible = bandvis;
    resolution = res;
  }
  
  void display(float[] spectrum) {
    fill(0);
    stroke(255);
    for(int i = 0; i < bands; i+=resolution){
      fill(spectrum[i]*50, 0,0);
      //stroke(255);
      int div = bandsVisible;
      float tweak = 1;
      if (mode == 2) {
        pushMatrix();
        translate((i/resolution*width/div),height);
        box(width/div, (spectrum[i]*height*sensitivity*tweak), width/div);
        popMatrix();
      }
      if (mode == 3) {
        pushMatrix();
        translate((i/resolution*width/div),0);
        box(width/div, (spectrum[i]*height*sensitivity*tweak), width/div);
        popMatrix();
      }
      if (mode == 4) {
        pushMatrix();
        translate((i/resolution*width/div),height/2);
        box(width/div, (spectrum[i]*height*sensitivity*tweak), width/div);
        popMatrix();
      }
    }
  }
}