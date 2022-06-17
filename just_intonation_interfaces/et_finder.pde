int findET() {
  for (int prime : primes) {
    float otonalInterval = prime/pow(equave, floor(log(prime)/log(equave))); // Otonal
    basicIntervals.add(otonalInterval);
    otonalIntervals.add(otonalInterval);
    basicIntervals.add(pow(equave, 1+ floor(log(prime)/log(equave)))/prime); // Utonal
  }

  // Iterate ETs from MIN_ET to MAX_ET
  int bestET = 0;
  float minTotalDistance = 1000;
  for (int et=MIN_ET; et<MAX_ET; et++) {
    float totalDistance = 0;
    // Iterate through all basic (just) intervals
    for (float interval : basicIntervals) {
      float minDistance = 1000;

      // Iterate through all the tones of the ET
      for (int tone=0; tone<et+1; tone++) {
        float intervalCents = et*100*log(interval)/log(equave); // Cents of the just tone
        float ettCents = 100*tone; // Cents of the tempered tone
        float distance = abs(ettCents-intervalCents);
        if (distance<minDistance) minDistance = distance;
      }
      totalDistance += minDistance;
    }
    if (totalDistance<minTotalDistance) {
      minTotalDistance = totalDistance;  
      bestET = et;
    }
  }
  return bestET;
}

int findNTone(float interval) {
  int closestTone = 0;
  float minDistance = 1000.;
  
  for (int tone=0; tone<et+1; tone++) {
    float toneRatio = pow(equave, tone/float(et));
    float distance = abs(toneRatio-interval);
    if (distance<minDistance) {
      closestTone = tone;
      minDistance = distance;
    }
  }
  return closestTone%et;
}
