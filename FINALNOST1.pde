import processing.pdf.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;

PGraphics canvas;

Minim minim;
AudioInput in;
FFT fft;
int sampleRate= 22050;//sapleRate ofr 44100

Gain gain;


boolean crt=false;
float r;
float x;
float y;
float c;
float d;
int a;
int b;
float e;
float f;
float g;
float h;
float j;
float k;
float l;
int value;
int number=0;
void setup()
{

fullScreen();
  background(200);
  canvas = createGraphics(width, height);
  frameRate(30);
  
  minim = new Minim(this);
  minim.debugOn();
  in = minim.getLineIn(Minim.MONO, 256, sampleRate);
  fft = new FFT(in.left.size(), sampleRate);
  gain = new Gain(60);
}

void draw() {
  background(200);
  surface.setTitle(int(frameRate) + " fps");

  if (crt=true) { 
    x = lerp(x, mouseX, 0.5); //što je bliže nuli, to više interpolira. i obrnuto ofc
    y = lerp(y, mouseY, 0.5); //što je bliže nuli, to više interpolira. i obrnuto ofc
  }

  if (in.left.level()>0.004) {
    crt=true;
  } else crt=false;

  if (in.left.level()>0.01) {
    b = int(random(100, 350));
  } else if (in.left.level()>0.06) {
    b = int(random(110, 130));
  } else if (in.left.level()>0.1) {  
    b = int(random(130, 160));
  } else if (in.left.level()>0.3) {  
    b = int(random(160, 250));
  } else if (in.left.level()>0.5) {  
    b = int(random(250, 350));
  } else { 
    b = int(random(-200, 800));
  }

  if (in.left.level()>0.01) {
    f = int(random(width/2-20, width/2+20));
  } else if (in.left.level()>0.06) {
    f = int(random(width/2-100, width/2+100));
  } else if (in.left.level()>0.1) {  
    f = int(random(width/2-200, width/2+200));
  } else if (in.left.level()>0.3) {  
    f = int(random(width/2-500, width/2+500));
  } else if (in.left.level()>0.5) {  
    f = int(random(width/2-700, width/2+700));
  } else { 
    b = int(random(-200, 800));
  }









  fadeGraphics(canvas, 2); 
  canvas.beginDraw();   

  for (int i = 0; i < in.bufferSize() - 1; i++)
  {
    if (crt==true) {
      int a = int(random(in.left.get(i)*4000, in.left.get(i+1)*4000));
      float c =(in.left.level()*10000);
      float d =map(in.left.get(i+1),0.0001,0.18,860,1060);
      float e =(random(height));
      float f =(random(300, 1620));
      float h =map(in.left.level(),0.0001,0.18,50,0);
      float g =map(in.left.level(),0.0085,0.1,1,15);
      float j =map(in.left.get(i+1),0.0001,0.18,1560,1660);
      float k =map(in.left.get(i+1),0.0001,0.18,460,500);
      
      canvas.noFill();
      canvas.stroke(0);
      canvas.strokeWeight(abs(g));
      canvas.beginShape();
      canvas.curveVertex(f, c+500); 
      canvas.curveVertex(f, c+500); 
      canvas.curveVertex(d,b); 
      canvas.curveVertex(j,k); 
      canvas.curveVertex(c, e); 
      canvas.curveVertex(c, e);
    } else
      crt=false;
    break;
  }
  canvas.endShape();
  canvas.endDraw();
  image(canvas, 0, 0);


    if (key == 'F' || key == 'f') // ako stisneš F ili f, izbrišeš sve
      background(200);

}


void fadeGraphics(PGraphics c, int fadeAmount) {
  c.beginDraw();
  c.loadPixels();

  // iterate over pixels
  for (int i =0; i<c.pixels.length; i++) {

    // get alpha value
    int alpha = (c.pixels[i] >> 24) & 0xFF ;

    // reduce alpha value
    alpha = max(0, alpha-fadeAmount);

    // assign color with new alpha-value
    c.pixels[i] = alpha<<24 | (c.pixels[i]) & 0xFFFFFF ;
  }

  canvas.updatePixels();
  canvas.endDraw();
}