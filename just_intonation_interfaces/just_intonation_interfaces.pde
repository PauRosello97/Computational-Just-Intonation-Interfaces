import java.util.Arrays;
import java.util.List;

final int[] primes = {3, 5};
final int equave = 2;
final int MIN_ET = 10;
final int MAX_ET = 30;

int radiusX = 1;
int radiusY = 1;

ArrayList<Float> basicIntervals = new ArrayList<Float>(); 
ArrayList<Float> otonalIntervals = new ArrayList<Float>();
Tone[][] tones;
int[][] toneTree;
ArrayList<Integer> selectedTones = new ArrayList<Integer>();
ArrayList<int[]> scales;

int et;
int etW, etH;
ArrayList<Integer> etDimensions = new ArrayList<Integer>(); // Dimensions of the space that's repeating. For example, {3, 12} in [3, 5] -> 2.
float cellSize;
int selectedScale = 0;
int selectedMode = 0;
int nVariations, whiteTones;
int playingTone = -1;

float[] tonalCenter = {6, 2};
int[][] intervals;

void setup() {
  size(900, 900);
  et = findET();
  println("ET", et);
  setScale();
}

void setScale() {
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
  
  println("rX", radiusX);

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

  // Set ET size
  etW = radiusX*2+1;
  etH = radiusY*2+1;

  cellSize = width/float(et+1);

  /* FIND COPRIMES */
  int blackTones = et/2;
  whiteTones = et-blackTones;
  while (gcd(blackTones, whiteTones)!=1) {
    whiteTones += 1;
    blackTones -= 1;
  }

  /* TONE TREE */
  toneTree = new int[whiteTones-1][2];
  for (int i=0; i<toneTree.length; i++) {
    int extra = et%2==0 && i>=whiteTones/2 ? 0 : 1;
    toneTree[i][0] = i*2+extra;
    toneTree[i][1] = i*2+extra+1;
    
  }
  
  scales = new ArrayList<int[]>();
  /* BINARY */
  int seedLength = (whiteTones-1)/2;
  nVariations = (int)pow(2, seedLength);
  if (whiteTones%2==0) nVariations*=2;
  
  println(seedLength, nVariations);

  for (int i=0; i<nVariations; i++) {
    int k = whiteTones%2==0 ? i/2 : i;
    String binarySeed = binary(k, seedLength);

    String secondHalf = new StringBuilder(binarySeed).reverse().toString();
    if (whiteTones%2==0) {
      binarySeed += i%2;
    }
    secondHalf = secondHalf.replace('1', '2');
    secondHalf = secondHalf.replace('0', '1');
    secondHalf = secondHalf.replace('2', '0');
    binarySeed += secondHalf;

    int[] tones = new int[whiteTones];
    tones[0] = 0;

    for (int j=0; j<binarySeed.length(); j++) {
      int c = binarySeed.charAt(j) == '1' ? 1 : 0;
      tones[j+1] = toneTree[j][c];
    }

    int[] steps = getSteps(tones);
    steps = inversion(steps, selectedMode);

    // Set tones again (to apply mode)
    int[] new_tones = new int[tones.length];
    new_tones[0] = 0;
    for (int j=0; j<tones.length-1; j++) {
      new_tones[j+1] = new_tones[j] + steps[j];
    }    

    scales.add(new_tones);
  }

  /* CREATE TONES */
  tones = new Tone[etH][etW];
  for (int row=0; row<etH; row++) {
    tones[row] = new Tone[etW];
    for (int col=0; col<etW; col++) {
      tones[row][col] = new Tone(row, col);
    }
  }

  selectedTones = new ArrayList<Integer>();
  for (int t : scales.get(selectedScale)) selectedTones.add(t);

  int[] steps = getSteps(scales.get(selectedScale));

  if (arrayContains(steps, 0)) nextScale();

  setIntervals();
}

void draw() {
  background(255);

  for (Tone[] row : tones) for (Tone tone : row) tone.draw();

  textAlign(CENTER);
  for (int i=0; i<et*3; i++) {
    boolean contained = selectedTones.contains(i%et);
    fill(contained ? 255 : 0);
    if (i == playingTone) fill(255, 0, 0);
    rect(20+i*23, 400 + (contained ? 0 :-10), 23, 60+ (contained ? 0 :-10));
    fill(contained ? 0 : 255);
    text(i%et, 20+(i+.5)*23, 415+ (contained ? 0 :-10));
  }

  for (int i=0; i<et*3; i++) {
    int n = i%et;
    int e = i/et; // What equave?
    
    fill(0);
    text(intervals[n][0]*(int)pow(equave, e), 20+(i+.5)*23, 480);
    line(12+(i+.5)*23, 485, 28+(i+.5)*23, 485);
    text(intervals[n][1], 20+(i+.5)*23, 500);
  }

  fill(0);
  ellipse(cellSize*(tonalCenter[0]+.5), cellSize*(tonalCenter[1]+.5), 20, 20);
}
