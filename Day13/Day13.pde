import java.util.Collections;
String[] inp;
void setup() {
  inp = loadStrings("input.txt");


  ArrayList<Integer> depart =  cleanInput(inp[1]);
  int ourTime = Integer.parseInt(inp[0]);
  println(departAndWait(depart, ourTime));
}


ArrayList<Integer> cleanInput(String times) {
  ArrayList<Integer> out= new ArrayList<Integer>();
  String [] temp = times.split(",");

  for (String q : temp) {
    //print(q);
    if (q.indexOf('x') == -1) {
      out.add(Integer.parseInt(q));
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
