import java.util.*;

String[] inp;


void setup() {
  inp = loadStrings("input.txt");
  long [] inpPrime = listInt(inp);
  println(fitstFailure(inpPrime, 25));
  println(weakness(inpPrime, 25));
}


long [] listInt(String[] inp) {
  long[] temp = new long [inp.length];  

  for (int i = 0; i<inp.length; i++) {
    temp[i] = Long.parseLong(inp[i], 10);
  }
  return temp;
}




long  fitstFailure(long [] inp, int preamble) {


  for (int  i = preamble; i<inp.length; i++) { // 24 might be wrong;
    if (!sumPossible(Arrays.copyOfRange(inp, i-preamble, i), inp[i])) {
      return inp[i];
    }
  }
  return -1;
}



boolean sumPossible(long [] per, long  goal) {
  for (int i = 0; i<per.length; i++) {
    long  friend = goal - per[i];
    if (contains(per, friend)) {
      return true;
    }
  }
  return false;
}

boolean contains(long [] input, long  search ) {
  for (long  q : input) {
    if (q == search) {
      return true;
    }
  }

  return false;
}


long weakness(long[] inp, int preamble) {
  long goal = fitstFailure(inp, preamble);

  for (int i = 0; i<inp.length; i++) {
    for (int j = 1; j<inp.length; j++) {
      if(sum(inp, i,j) == goal){
        
        long[] temp = Arrays.copyOfRange(inp, i, j);
        Arrays.sort(temp);
        
        return temp[0] + temp[temp.length-1];
      }
      
    }
  }
  
  return -1;
}

long sum(long[] inp, int low, int hi) {
  long temp= 0;
  for (int i = low; i<hi; i++) {
    //println(i, inp[i]);
    temp+=inp[i];
  }
  return temp;
}
