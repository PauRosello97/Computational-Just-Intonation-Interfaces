class Tone{
  int x, y;
  int o, u; // Otonal  and utonal dimensions
  
  float ratio;
  int num = 1, denom = 1;
  
  int n; // Position of tone in ET
  
  Tone(int y, int x){
    this.x = x;
    this.y = y;
    o = x-radiusX;
    u = -y+radiusY;
        
    // Get ratio and fraction
    
    if(o>0) num*=pow(primes[0], o);
    else denom*=pow(primes[0], -o);   
    
    if(u>0) num*=pow(primes[1], u);
    else denom*=pow(primes[1], -u);  
    
    while(num/float(denom)>equave) denom*=equave;
    while(num/float(denom)<1) num*=equave;
        
    ratio = pow(primes[0], o)*pow(primes[1], u);
    while(ratio>equave) ratio/=equave;
    while(ratio<1) ratio*=equave;
    
    n = findNTone(ratio);
    
  }
  
  void draw(){
    if(n==0) fill(255, 0, 0);
    else if(selectedTones.contains(n)) fill(127, 127, 255);
    else fill(255);
    rect(cellSize*x, cellSize*y, cellSize, cellSize);
    
    fill(0);
    textAlign(CENTER);
    text(num, cellSize*(x+.5), cellSize*(y+.45));
    text(denom, cellSize*(x+.5), cellSize*(y+.7));
    line(cellSize*(x+.3), cellSize*(y+.5), cellSize*(x+.7), cellSize*(y+.5));
    //text(n, cellSize*(x+.5), cellSize*(y+.5));
  }
  
  void mousePressed(){
    if(mouseX>cellSize*x && mouseX<cellSize*(x+1) && mouseY>cellSize*y && mouseY<cellSize*(y+1)){
      if(selectedTones.contains(n)) selectedTones.remove(selectedTones.indexOf(n));
      else selectedTones.add(n);
    }
  }
}
