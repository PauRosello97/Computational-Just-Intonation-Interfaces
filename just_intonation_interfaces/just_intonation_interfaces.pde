final int[] primes = {5, 7};
final int equave = 3;
final int MIN_ET = 10;
final int MAX_ET = 30;

int radiusX = 1;
int radiusY = 1;

ArrayList<Float> basicIntervals = new ArrayList<Float>(); 
ArrayList<Float> otonalIntervals = new ArrayList<Float>();
Tone[][] tones;

int et;
int etW, etH;
ArrayList<Integer> etDimensions = new ArrayList<Integer>(); // Dimensions of the space that's repeating. For example, {3, 12} in [3, 5] -> 2.
float cellSize;

void setup() {
  size(900, 900);
  et = findET();

  //for (float interval : otonalIntervals) println(findNTone(interval));

  /* FIND ET WIDTH */
  radiusX = 1;
  ArrayList<Integer> xTones = new ArrayList<Integer>();
  while (!anyRepeated(xTones)) {
    float x = pow(primes[0], radiusX);
    float oIx = x/pow(equave, floor(log(x)/log(equave)));
    float uIx = pow(equave, 1+ floor(log(x)/log(equave)))/x;
    radiusX++;
    xTones.add(findNTone(oIx));
    xTones.add(findNTone(uIx));
  }  
  radiusX--;

  /* FIND ET HEIGHT */
  radiusY = 1;
  ArrayList<Integer> yTones = new ArrayList<Integer>();
  while (!anyRepeated(yTones)) {
    float y = pow(primes[1], radiusY);
    float oIy = y/pow(equave, floor(log(y)/log(equave)));
    float uIy = pow(equave, 1+ floor(log(y)/log(equave)))/y;
    radiusY++;
    yTones.add(findNTone(oIy));
    yTones.add(findNTone(uIy));
  }
  radiusY--;
  println(radiusX, radiusY);

  // Set ET size
  etW = radiusX*2+1;
  etH = radiusY*2+1;

  /* CREATE TONES */
  tones = new Tone[etH][etW];
  for (int row=0; row<etH; row++) {
    tones[row] = new Tone[etW];
    for (int col=0; col<etW; col++) {
      tones[row][col] = new Tone(row, col);
    }
  }

  cellSize = width/float(et+1);
}

void draw() {
  for (Tone[] row : tones) for(Tone tone : row) tone.draw();
  noLoop();
}
