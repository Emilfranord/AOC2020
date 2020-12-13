import java.util.Collections;
String[] inp;
void setup() {
  inp = loadStrings("input.txt");


  ArrayList<Integer> depart =  cleanInput(inp[1]);
  int ourTime = Integer.parseInt(inp[0]);
  //println(departAndWait(depart, ourTime));
  println("the answer to part two is: "+partTwo(depart));
  println("It took "+millis()/1000.0);
}


ArrayList<Integer> cleanInput(String times) {
  ArrayList<Integer> out= new ArrayList<Integer>();
  String [] temp = times.split(",");

  for (String q : temp) {
    //print(q);
    if (q.indexOf('x') == -1) {
      out.add(Integer.parseInt(q));
    } else {
      out.add(null);
    }
  }
  return out;
} 

// Collections.max(d)+2

int departAndWait(ArrayList<Integer> d, int t) {
  for (int i = 0; i < 1000; i++ ) {
    for (Integer q : d) {
      //println((i+t) % q);

      if (((i+t) % q) == 0) {

        return q * i;
      }
    }
  }
  return -1;
}


long partTwo(ArrayList<Integer> d) { // 2147483647
  for (long i = 100188000000000L; i<Long.MAX_VALUE; i+=23) {
    //println(check(i, d));
    if (i %  2300000000L == 0) {
      //print(i+ " ");
    }

    if (check(i, d)) {

      return i;
    }
  }
  return -1;
}

boolean check(long timestamp, ArrayList<Integer> d) {
  for (int i = 0; i < d.size(); i++) {
    if (d.get(i) != null) {
      if (d.get(i) != null && !((timestamp+i) % d.get(i) == 0)) {
        return false;
      }
    }
  }

  return true;
}
