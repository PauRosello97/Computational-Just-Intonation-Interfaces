// Count repetitions in ArrayList of tones

boolean anyRepeated(ArrayList<Integer> tones) {
  int[] counter = new int[et];
  for (int tone : tones) {
    counter[tone]++;
    if (counter[tone]>1) return true;
  }
  return false;
}

// https://www.baeldung.com/java-greatest-common-divisor
int gcd(int n1, int n2) {
  int gcd = 1;
  for (int i = 1; i <= n1 && i <= n2; i++) {
    if (n1 % i == 0 && n2 % i == 0) {
      gcd = i;
    }
  }
  return gcd;
}

// Generate inversions of an array
int[] inversion(int[] a, int v) {
  int[] new_a = new int[a.length];
  for (int i=0; i<a.length; i++) {
    new_a[i] = a[(i+v)%a.length];
  }
  return new_a;
}

// Get steps from tone array
int[] getSteps(int[] tones) {
  int[] steps = new int[tones.length];
  for (int j=0; j<tones.length-1; j++) {
    steps[j] = tones[j+1]-tones[j];
  }
  steps[steps.length-1] = et-tones[tones.length-1];
  return steps;
}

// Check if array contains a value
boolean arrayContains(int[] a, int v) {
  for (int x : a) if (x==v) return true;
  return false;
}

// Get position of element in array
int indexOf(int[] a, int v) {
  for (int i=0; i<a.length; i++) if (a[i] == v) return i;
  return -1;
}
