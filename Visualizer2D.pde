import processing.sound.*;
class Visualizer2D {
  int sensitivity;
  int bandsVisible;
  int resolution;
  Visualizer2D(int sens, int bandvis, int res) {
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
        rect((i/resolution*width/div),height, width/div, -(spectrum[i]*height*sensitivity*tweak) );
      }
      if (mode == 3) {
        rect((i/resolution*width/div),0, width/div, (spectrum[i]*height*sensitivity*tweak) );
      }
      if (mode == 4) {
        rect((i/resolution*width/div),0, width/div, height/2-(spectrum[i]*height*sensitivity*tweak) );
        rect((i/resolution*width/div),height, width/div, -height/2+(spectrum[i]*height*sensitivity*tweak) );
      }
    }
  }
}