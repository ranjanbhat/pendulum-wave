float dt=0.01;
float t=0;
float g=40;
float colr=0;
float x=0;
int n=20;
float m=1000;
float depth,am;
float len=800;
float xangle=0;
float yangle=-PI/8;
Pendulum arr[]=new Pendulum[n];

void setup()
{
  fullScreen(P3D);
  colorMode(HSB);
  am=PI/8;
  depth=0;
  for(int i=0; i<n; i++)
  {
    arr[i]=new Pendulum(am,depth,len);
    len-=300/n;
    //am+=0.35/n;
    depth-=80;
  }
  depth+=40;
}

void keyPressed()
{
  if(key=='=' || key=='+')
  m=m*2;  
  else
  if(key=='-')
  m/=2;
  else 
  if(keyCode==RIGHT) yangle+=0.1;
  else
  if(keyCode==LEFT)  yangle-=0.1;
  else
  if(keyCode==UP) xangle+=0.1;
  else
  if(keyCode==DOWN)  xangle-=0.1;
  else
  if(keyCode==ESC) exit();
}


void draw()
{
  directionalLight(255,0,255,1000,1000,-1000);
  background(0);
  translate(width/2,height/10,depth/2);
  rotateY(yangle);
  rotateX(xangle);
  translate(0,0,-depth/2);
  stroke(255);
  strokeWeight(4);
  line(0,0,-10000,0,0,10000);
  line(0,900,-10000,0,900,10000);
  for(int i=0; i<m; i+=1000)
  {
  for(Pendulum P: arr){ P.display(); P.update();}
  t+=dt;
  }
}

class Pendulum
{
  float amp;
  float theta;
  float v;
  float a;
  float l;
  float depth;
  color col;
  Pendulum(float val,float d,float len)
  {
    amp=val;
    theta=amp;
    l=len;
    depth=d;
    v=0;
    a= -g*200*sin(theta)/l;
    col=color(colr,255,255);
    colr+=40.0/n;
  }
   
  void update()
  {
    v+= a*dt;
    theta+=v*dt;
    a= -g*200*sin(theta)/l;
  }
  
  void display()
  {
    stroke(255);
    strokeWeight(1);
    line(0,0,depth,l*sin(theta),l*cos(theta),depth);
    fill(col);
    noStroke();
    translate(l*sin(theta),l*cos(theta),depth);
    sphere(40);
    translate(-l*sin(theta),-l*cos(theta),-depth);
  }
}
