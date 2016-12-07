import peasy.*;
import shapes3d.*;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];

int mode = 1;
int sensitivity = 50;
int bandsVisible = 32;
int resolution = 1;
ArrayList<SquareSpiral> spirals = new ArrayList<SquareSpiral>();
Visualizer3D v2d_one = new Visualizer3D(sensitivity, bandsVisible, resolution);
PeasyCam pc;
boolean help = true, debug = true;
void setup() {
  //pc = new PeasyCam(this, 1000);
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  // start the Audio Input
  in.start();
  // patch the AudioIn
  fft.input(in);
  spirals.add(new SquareSpiral(50,5));
  //spirals.add(new SquareSpiral(50,10));
  //spirals.add(new SquareSpiral(25,20));
  //spirals.add(new SquareSpiral(25,30));
  size(1280,720,P3D);
}

void draw() { 
  fft.analyze(spectrum);
  float bassThreshold = 0;
  float maxThreshold = 0;
  for (int i = 0; i < bands; ++i) {
    if (spectrum[i] > maxThreshold)
      maxThreshold = spectrum[i];
  }
  
  for(int i = 0; i < 5; ++i)
    bassThreshold += spectrum[i];
  bassThreshold = bassThreshold/5 * sensitivity;
  
  if (keyPressed) {
    if (key == '=' && bandsVisible < bands/resolution - 2)
      bandsVisible += 2;
    else if (key == '-' && bandsVisible > 2)
      bandsVisible -= 2;
    else if (key == ',' && sensitivity > 0)
      --sensitivity;
    else if (key == '.')
      ++sensitivity;
    else if (key == '[' && resolution > 2) {
      resolution-=2;
      bandsVisible = bands/resolution;
    }
    else if (key == ']' && resolution < 128) {
      resolution+=2;
      bandsVisible = bands/resolution ;
    }
    else if (key == '1')
      mode = 1;
    else if (key == '2')
      mode = 2;
    else if (key == '3')
      mode = 3;
    else if (key == '4')
      mode = 4;
    else if (key == 'h') {
      help = !help;
      delay(100);
    }
    else if (key == 'd') {
      debug = !debug;
      delay(100);
    }
  }
  background(255);
  v2d_one.update(sensitivity, bandsVisible, resolution);
  v2d_one.display(spectrum);
  for (int i = 0; i < spirals.size(); ++i) {
    spirals.get(i).update(bassThreshold*(i+1));
    spirals.get(i).display();
  }
  if (help) {
    textSize(32);
    fill(0,102,153);
    text("Help:", 10, 30);
    textSize(16);
    text("Toggle Debug Menu: 'D'", 30, 50);
    text("Toggle Help Menu:  'H'", 30, 70);
    text("Instruction:         Down  Up", 30, 90);
    text("Frequency Scope:      -     +", 30, 110);
    text("Frequency Resolution: [     ]", 30, 130);
    text("Volume/Sensitivity:   <     >", 30, 150);
  }
  if (debug) {
    textSize(32);
    fill(102,153,0);
    text("Debug:", 300, 30);
    textSize(16);
    text("Frequency Scope: " + Integer.toString(bandsVisible), 330, 50);
    text("Frequency Resolution: " + Integer.toString(resolution), 330, 70);
    text("Volume/Sensitivity: " + Integer.toString(sensitivity), 330, 90);
  }
}