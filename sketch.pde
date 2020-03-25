int w,h;
int[][] raster;

Spinne[] s;


void setup(){

  frameRate(20);

  w = window.innerWidth;
  h = window.innerHeight

  smooth();
  size(w, h);


  // size(1000, 1000);
  // smooth();
  //w = width;
  //h = height;
  
  raster = new int[w][h];

  s = new Spinne[5];
  
  for(int i = 0; i < s.length; i++){
    s[i] = new Spinne(s);
  }
}


void draw(){
  background(17,17,17,0);
  
  for(int i = 0; i < s.length; i++){
    s[i].display();
  }
}



class Spinne {
  
  int x,y;
  int u,t;
  int beinlen;
  float nextX,nextY;
  int distance;
  int speed;
  float speedx, speedy;
  boolean waiting;
  Spinne[] others;
  
  Spinne(Spinne[] oin){
    others = oin;
    x = 0;
    y = 0;
    nextX=int(w/2)+1;
    nextY=int(h/2)+1;
    waiting = false;
    t = int(random(120,140));
    
  }
  
  void connect(){
    for(int i = 0; i < s.length; i++){
      int dx = others[i].getX();
      int dy = others[i].getY();
      int distance = int(dist(dx,dy,x,y));
      if (distance < 300) {
        stroke(74, 138, 124);
        line(x,y,dx,dy);
      }
    }
  }
  
  int getX(){
    return x;
  }
  
  int getY(){
    return y; 
  }
  
  void nextPos(){
    if( frameCount % t == 0 ) {
      nextX = random(0,w);
      nextY = random(0,h);
      t = int(random(120,180));
    }
  }
  
  void Beine(){
    if( frameCount % 10 == 0 ) {
      beinlen = int(random(50,90));
    }
  }
  
  void Krabbeln(){
    nextPos();
    distance=int(dist(x,y,nextX,nextY));
    speed = distance/40;
    speedx = (nextX - x) / distance * speed;
    speedy = (nextY - y) / distance * speed; 
    x += speedx;
    y += speedy;
  }
  
  void display(){
    connect();
    Krabbeln();
    Beine();
     for (int i = 0; i < w; i+=50) {
      for (int j = 0; j < h; j+=50) {
        stroke(0, 114, 93);
        int d = int(dist(x,y, i, j));
        if(d < beinlen){
          strokeWeight(2);
          line(i,j,x, y);
        }
      }
    }
    if(x <= 1 || y <= 1){
      x = w/2;
      y = h/2;
    }
  }
  
}
