int[] keys = {49, 50, 51, 52, 53, 54, 55, 56, 57, 58};

void playNote(int k) {
  playingTone = indexOf(keys, k);
  
  Tone closestTone = getClosestTone(tonalCenter, playingTone);
  tonalCenter[0] = closestTone.x;
  tonalCenter[1] = closestTone.y;
  println(playingTone);
  setIntervals();
}

void setIntervals() {
  intervals = new int[et][2];

  for (int i=0; i<et; i++) {
    Tone closestTone = getClosestTone(tonalCenter, i);
    int[] interval = {closestTone.num, closestTone.denom};
    intervals[i] = interval;
  }
}

Tone getClosestTone(float[] coordinates, int value) {
  float minDistance = 1000;
  Tone closestTone = null;
  for (Tone[] row : tones) {
    for (Tone tone : row) {
      if (tone.n == value) {
        float dx = tone.x-tonalCenter[0];
        float dy = tone.y-tonalCenter[1];
        float distance = sqrt(dx*dx+dy*dy);
        if (distance<minDistance) {
          minDistance = distance;  
          closestTone = tone;
        }
      }
    }
  }
  return closestTone;
}
